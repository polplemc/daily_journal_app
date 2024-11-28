import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/tag_system.dart';
import '../repository/tag_repo.dart';

class GetAllTags {
  final TagRepository repository;

  GetAllTags({required this.repository});

  Future<Either<Failure, List<Tag>>> call() {
    return repository.getAllTags();
  }
}

class GetTagById {
  final TagRepository repository;

  GetTagById({required this.repository});

  Future<Either<Failure, Tag?>> call(String id) {
    return repository.getTagById(id);
  }
}
