import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final String id; // Unique identifier for the tag
  final String name; // Tag name, e.g., "School", "Personal", "Fitness"

  const Tag({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}
