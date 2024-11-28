
import 'dart:convert';

import '../../domain/entities/journal_entry.dart';

class JournalEntryModel extends JournalEntry {
  const JournalEntryModel({
    required super.id,
    required super.date,
    required super.title,
    required super.content,
    required super.tags,
    super.imageUrl,
  });

  factory JournalEntryModel.fromMap(Map<String, dynamic> map) {
    return JournalEntryModel(
      id: map['id'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      content: map['content'],
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'],
    );
  }

  factory JournalEntryModel.fromJson(String source) =>
      JournalEntryModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
      'tags': tags,
      'imageUrl': imageUrl,
    };
  }

  String toJson() => json.encode(toMap());
}
