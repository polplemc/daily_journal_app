import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/features/tagging_system/data/data_source/tagging_remote_datasource.dart';
import 'package:myapp/features/tagging_system/data/models/tagging_system_model.dart';
import 'package:myapp/features/tagging_system/domain/entities/tag_system.dart';

class TaggingFirebaseRemoteDatasource implements TaggingRemoteDatasource {
  final FirebaseFirestore _firestore;

  const TaggingFirebaseRemoteDatasource(this._firestore);

  @override
  Future<void> createTag(Tag tag) async {
    try {
      final tagDocRef = _firestore.collection('tags').doc();
      final tagModel = TagModel(
        id: tagDocRef.id, 
        name: tag.name
      );

      await tagDocRef.set(tagModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> deleteTag(String id) async {
    try {
      await _firestore.collection('tags').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<Tag>> getAllTags() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('tags').get();
      return snapshot.docs.map((doc) {
        return Tag(
          id: doc.id,
          name: doc['name'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<Tag?> getTagById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('tags').doc(id).get();
      if (doc.exists) {
        return Tag(
          id: doc.id,
          name: doc['name'],
        );
      }
      return null; // Return null if tag does not exist
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> updateTag(Tag tag) async {
    final tagModel = TagModel(
      id: tag.id,
      name: tag.name,
    );

    try {
      await _firestore.collection('tags').doc(tag.id).update(tagModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
