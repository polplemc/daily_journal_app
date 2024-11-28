import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:myapp/features/journal_entry/presentation/cubit/journal_entry_cubit.dart';
import '../domain/entities/journal_entry.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: AddEditJournalEntry(
              journalEntry: JournalEntry(
        id: '32',
        date: DateTime(2024),
        title: 'day1',
        content: 'HEHE',
        tags: const ['School Event'],
      ))),
    ),
  );
}

class AddEditJournalEntry extends StatefulWidget {
  final JournalEntry? journalEntry;

  const AddEditJournalEntry({super.key, this.journalEntry});

  @override
  State<AddEditJournalEntry> createState() => _AddEditJournalEntryState();
}

class _AddEditJournalEntryState extends State<AddEditJournalEntry> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPerforming = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = widget.journalEntry == null
        ? 'Add New Journal Entry'
        : 'Edit Journal Entry';
    String buttonLabel = widget.journalEntry == null
        ? 'Add Journal Entry'
        : 'Edit Journal Entry';

    final initialValues = {
      'date': widget.journalEntry?.date,
      'title': widget.journalEntry?.title,
      'content': widget.journalEntry?.content,
      'tags': widget.journalEntry?.tags,
    };

    return BlocListener<JournalCubit, JournalEntryState>(
      listener: (context, state) {
        if (state is JournalEntryCreated) {
          Navigator.pop(context, "JournalEntry Added");
        } else if (state is JournalFailure) {
          final snackBar = SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            _isPerforming = false;
          });
        } else if (state is JournalEntryUpdated) {
          Navigator.pop(context, state.updatedEntry);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: Column(
          children: [
            Expanded(
                child: FormBuilder(
              key: _formKey,
              initialValue: initialValues,
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  FormBuilderDateTimePicker(
                    name: 'date',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'title',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'content',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Content',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FormBuilderTextField(
                    name: 'tags',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tags',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  )),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: _isPerforming
                        ? null
                        : () {
                            bool isValid = _formKey.currentState!.validate();
                            final inputs = _formKey.currentState!.instantValue;

                            if (isValid) {
                              setState(() {
                                _isPerforming = true;
                              });

                              final updatedEntry = JournalEntry(
                                id: widget.journalEntry?.id ?? "",
                                date: inputs["date"],
                                title: inputs["title"] ??
                                    "Default Title", // Provide fallback for title
                                content: inputs["content"] ??
                                    "Default Content", // Provide fallback for content
                                tags: inputs["tags"] ??
                                    [], // Provide fallback for tags
                              );

                              if (widget.journalEntry == null) {
                                context
                                    .read<JournalCubit>()
                                    .addJournalEntry(updatedEntry);
                              } else {
                                context
                                    .read<JournalCubit>()
                                    .updateJournal(updatedEntry);
                              }
                            }
                          },
                    child: _isPerforming
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text(buttonLabel),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
