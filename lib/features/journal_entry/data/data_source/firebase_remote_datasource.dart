import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../tagging_system/domain/entities/tag_system.dart';
import '../../domain/entities/journal_entry.dart';
import '../models/journal_entry_model.dart';
import 'journal_remote_datasource.dart';

class JournalFirebaseRemoteDatasource implements JournalRemoteDatasource {
  final FirebaseFirestore _firestore;

  const JournalFirebaseRemoteDatasource(this._firestore);

  @override
  Future<void> createJournalEntry(JournalEntry entry) async {
    try {
      final journalEntryDocRef = _firestore.collection('journalEntries').doc();
      final journalEntryModel = JournalEntryModel(
        id: journalEntryDocRef.id,
        date: entry.date,
        title: entry.title,
        content: entry.content,
        tags: entry.tags,
        imageUrl: entry.imageUrl,
      );

      await journalEntryDocRef.set(journalEntryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> deleteJournalEntry(String id) async {
    try {
      await _firestore.collection('journalEntries').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<JournalEntry>> getAllJournalEntries() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('journalEntries')
          .orderBy('date', descending: true)
          .get();
      return snapshot.docs.map((doc) {
        return JournalEntry(
          id: doc.id,
          date: doc['date'].toDate(),
          title: doc['title'],
          content: doc['content'],
          tags: List<String>.from(doc['tags']),
          imageUrl: doc['imageUrl'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<JournalEntry?> getJournalEntryById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('journalEntries').doc(id).get();
      if (doc.exists) {
        return JournalEntry(
          id: doc.id,
          date: doc['date'],
          title: doc['title'],
          content: doc['content'],
          tags: List<String>.from(doc['tags']),
          imageUrl: doc['imageUrl'],
        );
      }
      return null; // Return null if entry does not exist
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> updateJournalEntry(JournalEntry entry) async {
    final journalEntryModel = JournalEntryModel(
      id: entry.id,
      date: entry.date,
      title: entry.title,
      content: entry.content,
      tags: entry.tags,
      imageUrl: entry.imageUrl,
    );

    try {
      await _firestore
          .collection('journalEntries')
          .doc(entry.id)
          .update(journalEntryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occured',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  createTag(Tag tag) {}
}
