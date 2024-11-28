import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable{
  final String id; // Unique identifier
  final DateTime date;
  final String title;
  final String content;
  final List<String> tags;
  final String? imageUrl; // Optional image

  const JournalEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.tags,
    this.imageUrl,
  });
  
  @override
  List<Object?> get props => [id];

  String? get description => null;
}
