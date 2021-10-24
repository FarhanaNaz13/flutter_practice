part of 'audio_control_cubit.dart';

abstract class AudioRecorderState extends Equatable {
  const AudioRecorderState();

  @override
  List<Object> get props => [];
}

class AudioRecorderInitial extends AudioRecorderState {}

class AudioRecorderRecording extends AudioRecorderState {}

class AudioRecorderReady extends AudioRecorderState {
  final String path;

  AudioRecorderReady(this.path);
  @override
  List<Object> get props => [path];
}

class AudioRecorderLoading extends AudioRecorderState {}
