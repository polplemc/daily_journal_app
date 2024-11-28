import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/features/journal_entry/data/data_source/firebase_remote_datasource.dart';
import 'package:myapp/features/journal_entry/data/data_source/journal_remote_datasource.dart';
import 'package:myapp/features/journal_entry/data/repository_impl/journal_repo_impl.dart';
import 'package:myapp/features/journal_entry/domain/repository/journal_repo.dart';
import 'package:myapp/features/journal_entry/presentation/cubit/journal_entry_cubit.dart';
import 'package:myapp/features/journal_entry/domain/usecases/create_journal.dart';
import 'package:myapp/features/journal_entry/domain/usecases/get_journal.dart';
import 'package:myapp/features/journal_entry/domain/usecases/update_journal.dart';
import 'package:myapp/features/journal_entry/domain/usecases/delete_journal.dart';
import 'package:myapp/features/tagging_system/data/data_source/firebase_remote_datasource.dart';
import 'package:myapp/features/tagging_system/data/data_source/tagging_remote_datasource.dart';
import 'package:myapp/features/tagging_system/data/repository_impl/tagging_repo_impl.dart';
import 'package:myapp/features/tagging_system/domain/repository/tag_repo.dart';
import 'package:myapp/features/tagging_system/presentation/cubit/tagging_system_cubit.dart';
import 'package:myapp/features/tagging_system/domain/usecases/create_tag.dart';
import 'package:myapp/features/tagging_system/domain/usecases/get_tag.dart';
import 'package:myapp/features/tagging_system/domain/usecases/update_tag.dart';
import 'package:myapp/features/tagging_system/domain/usecases/delete_tag.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Feature #1 = JOURNAL

  // Presentation Layer
  serviceLocator.registerFactory(() => JournalCubit(
        getAllJournalEntries: serviceLocator(),
        getJournalEntryById: serviceLocator(),
        createJournalEntry: serviceLocator(),
        updateJournalEntry: serviceLocator(),
        deleteJournalEntry: serviceLocator(),
      ));

  // Domain Layer
  serviceLocator.registerLazySingleton(
      () => CreateJournalEntry(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetAllJournalEntries(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetJournalEntryById(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => UpdateJournalEntry(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => DeleteJournalEntry(repository: serviceLocator()));

  // Data Layer
  serviceLocator.registerLazySingleton<JournalRepository>(
      () => JournalRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<JournalRemoteDatasource>(
      () => JournalFirebaseRemoteDatasource(serviceLocator()));
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  //----------------------------------------------------

  // Feature #2 = TAG

  // Presentation Layer
  serviceLocator.registerFactory(() => TagCubit(
        getAllTags: serviceLocator(),
        getTagById: serviceLocator(),
        createTag: serviceLocator(),
        updateTag: serviceLocator(),
        deleteTag: serviceLocator(),
      ));

  // Domain Layer
  serviceLocator.registerLazySingleton(() => GetAllTags(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetTagById(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => CreateTag(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateTag(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteTag(repository: serviceLocator()));

  // Data Layer
  serviceLocator.registerLazySingleton<TagRepository>(
      () => TaggingRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<TaggingRemoteDatasource>(
      () => TaggingFirebaseRemoteDatasource(serviceLocator()));
}
