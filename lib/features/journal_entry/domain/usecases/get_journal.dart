import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/journal_entry.dart';
import '../repository/journal_repo.dart';

class GetAllJournalEntries {
  final JournalRepository repository;

  GetAllJournalEntries({required this.repository});

  Future<Either<Failure, List<JournalEntry>>> call() {
    return repository.getAllJournalEntries();
  }
}

class GetJournalEntryById {
  final JournalRepository repository;

  GetJournalEntryById({required this.repository});

  Future<Either<Failure, JournalEntry?>> call(String id) {
    return repository.getJournalEntryById(id);
  }
}
