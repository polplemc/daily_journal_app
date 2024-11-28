import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry.dart';
import '../repository/journal_repo.dart';

class CreateJournalEntry {
  final JournalRepository repository;

  CreateJournalEntry({required this.repository});

  Future<Either<Failure, void>> call(JournalEntry entry) {
    return repository.createJournalEntry(entry);
  }
}
