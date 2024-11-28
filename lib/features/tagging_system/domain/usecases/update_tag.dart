import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/tag_system.dart';
import '../repository/tag_repo.dart';

class UpdateTag {
  final TagRepository repository;

  UpdateTag({required this.repository});

  Future<Either<Failure, void>> call(Tag tag) {
    return repository.updateTag(tag);
  }
}