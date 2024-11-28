import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/journal_entry.dart';
import '../../domain/usecases/create_journal.dart';
import '../../domain/usecases/delete_journal.dart';
import '../../domain/usecases/get_journal.dart';
import '../../domain/usecases/update_journal.dart';

part 'journal_entry_state.dart';

const String noInternetErrorMessage =
    "Sync failed: Changes saved on your device and will sync once you're back online";

class JournalCubit extends Cubit<JournalEntryState> {
  final GetAllJournalEntries getAllJournalEntries;
  final GetJournalEntryById getJournalEntryById;
  final CreateJournalEntry createJournalEntry;
  final UpdateJournalEntry updateJournalEntry;
  final DeleteJournalEntry deleteJournalEntry;

  JournalCubit({
    required this.getAllJournalEntries,
    required this.getJournalEntryById,
    required this.createJournalEntry,
    required this.updateJournalEntry,
    required this.deleteJournalEntry,
  }) : super(JournalEntryInitial());

  Future<void> fetchAllJournalEntries() async {
    emit(JournalLoading());

    try {
      final result = await getAllJournalEntries().timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException("Request Time out"));
      result.fold(
        (failure) => emit(JournalFailure(failure.getMessage())),
        (entries) {
          emit(JournalLoaded(entries));
        },
      );
    } on TimeoutException catch (_) {
      emit(const JournalFailure(
          "There seems to be a problem with your Internet Connection"));
    }
  }

  Future<void> fetchJournalEntryById(String id) async {
    emit(JournalLoading());

    try {
      final result = await getJournalEntryById(id).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException("Request Time out"));
      result.fold(
        (failure) => emit(JournalFailure(failure.getMessage())),
        (entry) => emit(JournalEntryLoaded(entry!)),
      );
    } on TimeoutException catch (_) {
      emit(const JournalFailure(noInternetErrorMessage));
    }
  }

  Future<void> addJournalEntry(JournalEntry entry) async {
    emit(JournalLoading());

    try {
      final result = await createJournalEntry(entry).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException("Request Time out"));
      result.fold(
        (failure) => emit(JournalFailure(failure.getMessage())),
        (_) {
          emit(JournalEntryCreated(entry));
        },
      );
    } on TimeoutException catch (_) {
      emit(const JournalFailure(noInternetErrorMessage));
    }
  }

  Future<void> updateJournal(JournalEntry updatedEntry) async {
    emit(JournalLoading());

    try {
      final result = await updateJournalEntry(updatedEntry).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException("Request Time out"));
      result.fold(
        (failure) => emit(JournalFailure(failure.getMessage())),
        (_) {
          emit(JournalEntryUpdated(updatedEntry));
        },
      );
    } on TimeoutException catch (_) {
      emit(const JournalFailure(noInternetErrorMessage));
    }
  }

  Future<void> deleteJournalEntryById(String id) async {
    emit(JournalLoading());

    try {
      final result = await deleteJournalEntry(id).timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw TimeoutException("Request Time out"));
      result.fold(
        (failure) => emit(JournalFailure(failure.getMessage())),
        (_) {
          emit(JournalEntryDeleted(id));
        },
      );
    } on TimeoutException catch (_) {
      emit(const JournalFailure(noInternetErrorMessage));
    }
  }
}
