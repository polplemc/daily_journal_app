import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/injection_container.dart';
import 'package:myapp/features/journal_entry/presentation/add_edit_journal_entry.dart';
import 'package:myapp/features/journal_entry/presentation/cubit/journal_entry_cubit.dart';
import 'package:myapp/features/journal_entry/presentation/view_journal_entry_page.dart';

import '../../../core/widgets/empty_state_list.dart';
import '../../../core/widgets/error_state_list.dart';
import '../../../core/widgets/loading_state_shimmer_list.dart';

class ViewAllJournalsPage extends StatefulWidget {
  const ViewAllJournalsPage({super.key});

  @override
  State<ViewAllJournalsPage> createState() => _ViewAllJournalsPageState();
}

class _ViewAllJournalsPageState extends State<ViewAllJournalsPage> {
  @override
  void initState() {
    super.initState();
    context.read<JournalCubit>().fetchAllJournalEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Journal'),
      ),
      body: BlocBuilder<JournalCubit, JournalEntryState>(
        builder: (context, state) {
          if (state is JournalLoading) {
            return const LoadingStateShimmerList();
          } else if (state is JournalLoaded) {
            if (state.journalEntries.isEmpty) {
              return const EmptyStateList(
                imageAssetName:
                    'assets/images/_Pngtree_empty_box_icon_for_your_4820798-removebg-preview.png',
                title: 'Oppsss... There are no Journal Entries here',
                description: "Tap the '+' to add a new journal entry",
              );
            }

            return ListView.builder(
              itemCount: state.journalEntries.length,
              itemBuilder: (context, index) {
                final currentJournalEntries = state.journalEntries[index];

                return Card(
                  child: ListTile(
                    title: Text(currentJournalEntries.title),
                    subtitle: Text(currentJournalEntries.content),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => serviceLocator<JournalCubit>(),
                            child: ViewJournalEntryPage(
                              journalEntry: currentJournalEntries,
                            ),
                          ),
                        ),
                      );

                      // Refresh the page after navigating back
                      // ignore: use_build_context_synchronously
                      context.read<JournalCubit>().fetchAllJournalEntries();
                    },
                  ),
                );
              },
            );
          } else if (state is JournalFailure) {
            return ErrorStateList(
              imageAssetName:
                  'assets/images/—Pngtree—red error icon_5418881.png',
              errorMessage: state.message,
              onRetry: () {
                context.read<JournalCubit>().fetchAllJournalEntries();
              },
            );
          } else {
            return const EmptyStateList(
              imageAssetName:
                  'assets/images/_Pngtree_empty_box_icon_for_your_4820798-removebg-preview.png',
              title: 'Oppsss... There are no Journal Entries here',
              description: "Tap the '+' to add a new journal entry",
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (BuildContext context) {
                      return serviceLocator<JournalCubit>();
                    },
                  ),
                ],
                child: const AddEditJournalEntry(),
              ),
            ),
          );
          context.read<JournalCubit>().fetchAllJournalEntries();

          if (result != null) {
            final snackBar = SnackBar(
              content: Text(result as String),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
