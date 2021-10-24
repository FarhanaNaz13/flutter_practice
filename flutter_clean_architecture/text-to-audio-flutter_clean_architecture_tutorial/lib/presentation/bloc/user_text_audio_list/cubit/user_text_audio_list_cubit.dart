import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/domain/delete_user_text_audio_reset_status.dart';
import 'package:text_to_audio/domain/get_user_text_audio_list.dart';
import 'package:text_to_audio/domain/upload_text_audio.dart';

part 'user_text_audio_list_state.dart';

class UserTextAudioListCubit extends Cubit<UserTextAudioListState> {
  UserTextAudioListCubit(
    this._getUserTextAudioListUC,
    this._deleteUserTextAudioResetStatusUC,
    this._uploadTextAudioUC,
  ) : super(UserTextAudioListInitial());
  final GetUserTextAudioListUC _getUserTextAudioListUC;
  final DeleteUserTextAudioResetStatusUC _deleteUserTextAudioResetStatusUC;
  final UploadTextAudioUC _uploadTextAudioUC;

  Future<void> getUserTextAudioList() async {
    emit(UserTextAudioListLoading());
    try {
      final list = await _getUserTextAudioListUC();
      emit(UserTextAudioListLoaded(list));
    } catch (_) {
      emit(UserTextAudioListError());
    }
  }

  Future<void> deleteTextAudioList(List<UserTextAudio> list) async {
    try {
      await _deleteUserTextAudioResetStatusUC(list);
    } catch (e) {}
  }

  Future<void> upload(List<UserTextAudio> list) async {
    emit(UserTextAudioListLoading());
    try {
      await _uploadTextAudioUC(list);
    } catch (e) {
      print(e);
    }
  }
}
