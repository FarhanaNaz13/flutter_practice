import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/domain/get_selected_text_chunk.dart';
import 'package:text_to_audio/domain/get_new_text_chunk.dart';
import 'package:text_to_audio/domain/set_current_text.dart';

part 'selected_text_state.dart';

class SelectedTextCubit extends Cubit<SelectedTextState> {
  SelectedTextCubit(
    this._getSelectedTextChunkUC,
    this._setCurrentTextUC,
    this._getNewTextChunkUC,
  ) : super(
          SelectedTextInitial(), // emits this state initially
        );
  final GetSelectedTextChunkUC _getSelectedTextChunkUC;

  final SetCurrentTextUC _setCurrentTextUC;
  final GetNewTextChunkUC _getNewTextChunkUC;

  Future<void> getSelectedTextChunk() async {
    emit(
      SelectedTextLoading(), // state
    );
    try {
      final textChunk = await _getSelectedTextChunkUC();
      emit(
        SelectedTextLoaded(textChunk), //state
      );
    } catch (e) {
      print(e);
      emit(
        SelectedTextError(), // state
      );
    }
  }

  Future<void> updateSelectedText() async {
    try {
      final newTextChunk = await _getNewTextChunkUC();
      await _setCurrentTextUC(newTextChunk);
    } catch (e) {}
  }
}
