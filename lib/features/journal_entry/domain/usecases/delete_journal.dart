import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/journal_repo.dart';

class DeleteJournalEntry {
  final JournalRepository repository;
  DeleteJournalEntry({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteJournalEntry(id);
  }
}
