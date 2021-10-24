import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/domain/clear_current_audio.dart';
import 'package:text_to_audio/domain/delete_audio.dart';
import 'package:text_to_audio/domain/get_current_audio.dart';
import 'package:text_to_audio/domain/set_current_audio.dart';

part 'current_audio_state.dart';

class CurrentAudioCubit extends Cubit<CurrentAudioState> {
  CurrentAudioCubit(
    this._getCurrentAudioUC,
    this._deleteAudioUC,
    this._setCurrentAudioUC,
    this._clearCurrentAudioUC,
  ) : super(CurrentAudioInitial());
  final GetCurrentAudioUC _getCurrentAudioUC;
  final DeleteAudioUC _deleteAudioUC;
  final SetCurrentAudioUC _setCurrentAudioUC;
  final ClearCurrentAudioUC _clearCurrentAudioUC;

  Future<void> getCurrentAudio() async {
    emit(CurrentAudioLoading());
    try {
      final audio = await _getCurrentAudioUC();
      emit(CurrentAudioSuccess(audio));
    } catch (_) {
      emit(CurrentAudioError());
    }
  }

  Future<void> setCurrentAudio(Audio audio) async {
    try {
      await _setCurrentAudioUC(audio);
    } catch (_) {}
  }

  Future<void> deleteCurrentAudio() async {
    try {
      final audio = await _getCurrentAudioUC();
      await _deleteAudioUC(audio);
    } catch (_) {}
  }

  Future<void> clearCurrentAudio() async {
    try {
      await _clearCurrentAudioUC();
    } catch (_) {}
  }
}
