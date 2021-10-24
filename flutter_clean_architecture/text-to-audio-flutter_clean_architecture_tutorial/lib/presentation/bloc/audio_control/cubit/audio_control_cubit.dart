import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/domain/get_new_audio_path.dart';

part 'audio_control_state.dart';

class AudioRecorderCubit extends Cubit<AudioRecorderState> {
  AudioRecorderCubit(this._getNewAudioPathUC) : super(AudioRecorderInitial());
  
  final GetNewAudioPathUC _getNewAudioPathUC;

  Future<void> getNewAudioPath() async {
    emit(AudioRecorderLoading());
    try {
      final path = await _getNewAudioPathUC();
      emit(AudioRecorderReady(path));
    } catch(_) {

    }
  }
}
