import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/domain/add_user_text_audio.dart';
import 'package:text_to_audio/domain/get_current_audio.dart';
import 'package:text_to_audio/domain/get_selected_text_chunk.dart';

part 'current_user_text_audio_state.dart';

class CurrentUserTextAudioCubit extends Cubit<CurrentUserTextAudioState> {
  CurrentUserTextAudioCubit(
    this._getCurrentAudioUC,
    this._getSelectedTextChunkUC,
    this._addUserTextAudioUC,
  ) : super(CurrentUserTextAudioInitial());

  final GetCurrentAudioUC _getCurrentAudioUC;
  final GetSelectedTextChunkUC _getSelectedTextChunkUC;
  final AddUserTextAudioUC _addUserTextAudioUC;

  Future<void> storeCurrentUserTextAudio(String environment) async {
    emit(CurrentUserTextAudioLoading());

    late Audio audio;
    late TextChunk textChunk;

    try {
      audio = await _getCurrentAudioUC();
    } catch (_) {
      emit(CurrentUserTextAudioAudioNotFound());
      return;
    }
    try {
      textChunk = await _getSelectedTextChunkUC();
    } catch (_) {
      emit(CurrentUserTextAudioTextChunkNotFound());
      return;
    }
    try {
      await _addUserTextAudioUC(environment, textChunk, audio);
      emit(CurrentUserTextAudioSuccess());
    } catch (e) {
      emit(CurrentUserTextAudioStoringFailure());
    }
  }
}
