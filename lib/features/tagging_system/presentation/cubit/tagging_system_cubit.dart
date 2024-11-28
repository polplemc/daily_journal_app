import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tag_system.dart';
import '../../domain/usecases/create_tag.dart';
import '../../domain/usecases/delete_tag.dart';
import '../../domain/usecases/get_tag.dart';
import '../../domain/usecases/update_tag.dart';

part 'tagging_system_state.dart';

class TagCubit extends Cubit<TaggingSystemState> {
  final GetAllTags getAllTags;
  final GetTagById getTagById;
  final CreateTag createTag;
  final UpdateTag updateTag;
  final DeleteTag deleteTag;

  TagCubit({
    required this.getAllTags,
    required this.getTagById,
    required this.createTag,
    required this.updateTag,
    required this.deleteTag,
  }) : super(TaggingSystemInitial());

  static const String noInternetErrorMessage = "There seems to be a problem with your Internet connection.";

  // Fetch all tags
  Future<void> fetchAllTags() async {
    emit(TagLoading());

    try {
      final result = await getAllTags().timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );
      result.fold(
  (failure) => emit(TagFailure(failure.getMessage())),
  (tag) => emit(TaggingSystemLoaded([tag] as Tag)), // Wrap tag in a list
);

    } on TimeoutException {
      emit(const TagFailure(noInternetErrorMessage));
    }
  }

  // Fetch tag by ID
  Future<void> fetchTagById(String id) async {
    emit(TagLoading());

    try {
      final result = await getTagById(id).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );
      result.fold(
        (failure) => emit(TagFailure(failure.getMessage())),
        (tag) => emit(TaggingSystemLoaded(tag!)), // Ensure tag is not null
      );
    } on TimeoutException {
      emit(const TagFailure(noInternetErrorMessage));
    }
  }

  // Add a new tag
  Future<void> addTag(Tag tag) async {
    emit(TagLoading());

    try {
      final result = await createTag(tag).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );
      result.fold(
        (failure) => emit(TagFailure(failure.getMessage())),
        (_) {
          emit(TaggingSystemLoaded(tag));
        },
      );
    } on TimeoutException {
      emit(const TagFailure(noInternetErrorMessage));
    }
  }

  // Update an existing tag
  Future<void> updateTagEntry(Tag updatedTag) async {
    emit(TagLoading());

    try {
      final result = await updateTag(updatedTag).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );
      result.fold(
        (failure) => emit(TagFailure(failure.getMessage())),
        (_) => emit(TaggingSystemUpdated(updatedTag)), // Emitting updated tag
      );
    } on TimeoutException {
      emit(const TagFailure(noInternetErrorMessage));
    }
  }

  // Delete a tag by ID
  Future<void> deleteTagById(String id) async {
    emit(TagLoading());

    try {
      final result = await deleteTag(id).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );
      result.fold(
        (failure) => emit(TagFailure(failure.getMessage())),
        (_) => emit(TaggingSystemDeleted(id)), // Emitting ID of the deleted tag
      );
    } on TimeoutException {
      emit(const TagFailure(noInternetErrorMessage));
    }
  }
}
