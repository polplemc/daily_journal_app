import 'package:dartz/dartz.dart';


import '../../../../core/errors/failure.dart';
import '../entities/journal_entry.dart';

abstract class JournalRepository {
  Future<Either<Failure, void>> createJournalEntry(JournalEntry entry);
  Future<Either<Failure, List<JournalEntry>>> getAllJournalEntries();
  Future<Either<Failure, JournalEntry?>> getJournalEntryById(String id);
  Future<Either<Failure, void>> updateJournalEntry(JournalEntry entry);
  Future<Either<Failure, void>> deleteJournalEntry(String id);
}
