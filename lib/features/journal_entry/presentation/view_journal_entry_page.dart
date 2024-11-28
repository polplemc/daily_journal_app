import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/injection_container.dart';
import 'package:myapp/features/journal_entry/domain/entities/journal_entry.dart';
import 'package:myapp/features/journal_entry/presentation/add_edit_journal_entry.dart';
import 'package:myapp/features/journal_entry/presentation/cubit/journal_entry_cubit.dart';

import 'view_journal_entry_row.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          body: ViewJournalEntryPage(
              journalEntry: JournalEntry(
        id: '32',
        date: DateTime(2025),
        title: 'day1',
        content: 'Ble',
        tags: const ['School Event'],
      ))),
    ),
  );
}

class ViewJournalEntryPage extends StatefulWidget {
  final JournalEntry journalEntry;

  const ViewJournalEntryPage({
    super.key,
    required this.journalEntry,
  });

  @override
  State<ViewJournalEntryPage> createState() => _ViewJournalEntryPage();
}

class _ViewJournalEntryPage extends State<ViewJournalEntryPage> {
  late JournalEntry _currentJournalEntry;

  @override
  void initState() {
    super.initState();
    _currentJournalEntry = widget.journalEntry;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JournalCubit, JournalEntryState>(
      listener: (context, state) {
        if (state is JournalEntryDeleted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pop(context, "Journal Entry deleted");
        } else if (state is JournalFailure) {
          final snackBar = SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_currentJournalEntry.content),
          actions: [
            IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => serviceLocator<JournalCubit>(),
                        child: AddEditJournalEntry(
                          journalEntry: _currentJournalEntry,
                        ),
                      ),
                    ),
                  );
                  if (result.runtimeType == JournalEntry) {
                    setState(() {
                      _currentJournalEntry = result as JournalEntry;
                    });
                  }
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  const snackBar = SnackBar(
                    content: Text("Deleting Journal entry..."),
                    duration: Duration(seconds: 7),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  context
                      .read<JournalCubit>()
                      .deleteJournalEntry(widget.journalEntry as String);
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            LabelValueRow(
              label: "Date",
              value: _currentJournalEntry.date,
            ),
            LabelValueRow(
              label: "Title",
              value: _currentJournalEntry.title,
            ),
            LabelValueRow(
              label: "Content",
              value: _currentJournalEntry.content,
            ),
            LabelValueRow(
              label: "Tags",
              value: _currentJournalEntry.tags
                  .join(', '), // Format tags as a comma-separated string
            ),
          ],
        ),
      ),
    );
  }
}
