import '../../domain/entities/journal_entry.dart';

abstract class JournalRemoteDatasource {
  Future<void> createJournalEntry(JournalEntry entry);
  Future<List<JournalEntry>> getAllJournalEntries();
  Future<JournalEntry?> getJournalEntryById(String id);
  Future<void> updateJournalEntry(JournalEntry entry);
  Future<void> deleteJournalEntry(String id);
}