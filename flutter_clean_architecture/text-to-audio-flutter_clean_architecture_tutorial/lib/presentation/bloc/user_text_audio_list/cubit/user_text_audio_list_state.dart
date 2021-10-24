part of 'user_text_audio_list_cubit.dart';

abstract class UserTextAudioListState extends Equatable {
  const UserTextAudioListState();

  @override
  List<Object> get props => [];
}

class UserTextAudioListInitial extends UserTextAudioListState {}

class UserTextAudioListLoading extends UserTextAudioListState {}

class UserTextAudioListLoaded extends UserTextAudioListState {
  final List<UserTextAudio> list;

  UserTextAudioListLoaded(this.list);
  @override
  List<Object> get props => [list];
}

class UserTextAudioListError extends UserTextAudioListState {}
