import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/tag_repo.dart';

class DeleteTag {
  final TagRepository repository;

  DeleteTag({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteTag(id);
  }
}