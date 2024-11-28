import '../../domain/entities/tag_system.dart';

abstract class TaggingRemoteDatasource {
  Future<void> createTag(Tag tag);
  Future<List<Tag>> getAllTags();
  Future<Tag?> getTagById(String id);
  Future<void> updateTag(Tag tag);
  Future<void> deleteTag(String id);
}
