part of 'current_user_text_audio_cubit.dart';

abstract class CurrentUserTextAudioState extends Equatable {
  const CurrentUserTextAudioState();

  @override
  List<Object> get props => [];
}

class CurrentUserTextAudioInitial extends CurrentUserTextAudioState {}
class CurrentUserTextAudioLoading extends CurrentUserTextAudioState {}
class CurrentUserTextAudioUserNotFound extends CurrentUserTextAudioState {}
class CurrentUserTextAudioAudioNotFound extends CurrentUserTextAudioState {}
class CurrentUserTextAudioTextChunkNotFound extends CurrentUserTextAudioState {}
class CurrentUserTextAudioStoringFailure extends CurrentUserTextAudioState {}
class CurrentUserTextAudioSuccess extends CurrentUserTextAudioState{} 