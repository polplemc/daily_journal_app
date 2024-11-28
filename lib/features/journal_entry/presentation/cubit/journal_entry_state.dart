part of 'journal_entry_cubit.dart';

abstract class JournalEntryState extends Equatable {
  const JournalEntryState();

  @override
  List<Object?> get props => [];
}

class JournalEntryInitial extends JournalEntryState {}

class JournalLoading extends JournalEntryState {}

class JournalLoaded extends JournalEntryState {
  final List<JournalEntry> journalEntries;

  const JournalLoaded(this.journalEntries);

  @override
  List<Object?> get props => [journalEntries];
}

class JournalEntryLoaded extends JournalEntryState {
  final JournalEntry journalEntry;

  const JournalEntryLoaded(this.journalEntry);

  @override
  List<Object?> get props => [journalEntry];
}

////

class JournalEntryCreated extends JournalEntryState {
  final JournalEntry createdEntry;

  const JournalEntryCreated(this.createdEntry);

  @override
  List<Object?> get props => [createdEntry];
}

class JournalEntryDeleted extends JournalEntryState {
  final String id;

  const JournalEntryDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class JournalEntryUpdated extends JournalEntryState {
  final JournalEntry updatedEntry;

  const JournalEntryUpdated(this.updatedEntry);

  @override
  List<Object?> get props => [updatedEntry];
}

////

class JournalFailure extends JournalEntryState {
  final String message;

  const JournalFailure(this.message);

  @override
  List<Object?> get props => [message];
}
