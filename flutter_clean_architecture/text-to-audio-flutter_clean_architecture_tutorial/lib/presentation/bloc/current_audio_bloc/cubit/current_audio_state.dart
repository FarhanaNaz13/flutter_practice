part of 'current_audio_cubit.dart';

abstract class CurrentAudioState extends Equatable {
  const CurrentAudioState();

  @override
  List<Object> get props => [];
}

class CurrentAudioInitial extends CurrentAudioState {}

class CurrentAudioLoading extends CurrentAudioState {}

class CurrentAudioSuccess extends CurrentAudioState {
  final Audio audio;

  CurrentAudioSuccess(this.audio);
  @override
  List<Object> get props => [audio];
}

class CurrentAudioError extends CurrentAudioState {}
