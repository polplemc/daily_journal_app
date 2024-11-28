import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry.dart';
import '../repository/journal_repo.dart';

class UpdateJournalEntry {
  final JournalRepository repository;

  UpdateJournalEntry({required this.repository});

  Future<Either<Failure, void>> call(JournalEntry entry) {
    return repository.updateJournalEntry(entry);
  }
}
