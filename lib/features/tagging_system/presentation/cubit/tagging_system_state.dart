part of 'tagging_system_cubit.dart';

abstract class TaggingSystemState extends Equatable {
  const TaggingSystemState();

  @override
  List<Object?> get props => [];
}

class TaggingSystemInitial extends TaggingSystemState {}

class TagLoading extends TaggingSystemState {}

class TagLoaded extends TaggingSystemState {
  final List<Tag> tags;

  const TagLoaded(this.tags);

  @override
  List<Object?> get props => [tags];
}

class TaggingSystemLoaded extends TaggingSystemState {
const TaggingSystemLoaded(Tag tag);
}

////

class TaggingSystemDeleted extends TaggingSystemState {
  const TaggingSystemDeleted(String id);
}


class TaggingSystemUpdated extends TaggingSystemState {
  final Tag newTag;
   const TaggingSystemUpdated(this.newTag);

  @override
  List<Object?> get props => [newTag];
}

class TaggingSystemCreated extends TaggingSystemState{
  final Tag createdTag;

  const TaggingSystemCreated(this.createdTag);

  @override
  List<Object?> get props => [createdTag];

}



class TagLoadedById extends TaggingSystemState {
  final Tag tag;

  const TagLoadedById(this.tag);

  @override
  List<Object?> get props => [tag];
}

////

class TagFailure extends TaggingSystemState {
  final String message;

  const TagFailure(this.message);

  @override
  List<Object?> get props => [message];
}
