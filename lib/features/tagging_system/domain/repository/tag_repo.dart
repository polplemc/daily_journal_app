import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/tag_system.dart';

abstract class TagRepository {
  Future<Either<Failure, void>> createTag(Tag tag);
  Future<Either<Failure, List<Tag>>> getAllTags();
  Future<Either<Failure, Tag?>> getTagById(String id);
  Future<Either<Failure, void>> updateTag(Tag tag);
  Future<Either<Failure, void>> deleteTag(String id);
}
