import 'dart:convert';

import '../../domain/entities/tag_system.dart';

class TagModel extends Tag {
  const TagModel({
    required super.id,
    required super.name,
  });

  factory TagModel.fromMap(Map<String, dynamic> map) {
    return TagModel(
      id: map['id'],
      name: map['name'],
    );
  }

  factory TagModel.fromJson(String source) =>
      TagModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());
}
