import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/tag_system.dart';
import '../repository/tag_repo.dart';

class CreateTag {
  final TagRepository repository;

  CreateTag({required this.repository});

  Future<Either<Failure, void>> call(Tag tag) {
    return repository.createTag(tag);
  }
}
