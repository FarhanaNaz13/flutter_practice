import 'dart:io';

import 'package:text_to_audio/data/exception/delete_failed_exception.dart';
import 'package:text_to_audio/data/exception/file_upload_exception.dart';
import 'package:text_to_audio/data/model/delete/reset_status_request.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:http/http.dart' as _http;
import 'package:text_to_audio/data/source/api_header_provider.dart';
import 'package:text_to_audio/utils/api_constatns.dart';

abstract class UserTextAudioApi {
  Future<void> sendTextAudio(UserTextAudio textAudio);

  Future<void> delete(ResetStatusRequest deleteRequest);
}

class UserTextAudioApiImpl implements UserTextAudioApi {
  static const _audio_upload_endpoint =
      ApiConstants.base_url + '/dataset/v1/audio/upload';
  final ApiHeaderProvider _apiHeaderProvider;

  static const _delete_endpoint =
      ApiConstants.base_url + '/dataset/v1/transcription/reset-status';

  UserTextAudioApiImpl(this._apiHeaderProvider);

  @override
  Future<void> sendTextAudio(UserTextAudio textAudio) async {
    final headers = await _apiHeaderProvider.getGeneralHeaderMapWithAuth();
    final multipartRequest =
        _http.MultipartRequest('POST', Uri.parse(_audio_upload_endpoint));
    multipartRequest.fields.addAll({
      'environment': textAudio.environment,
      'transcriptionId': textAudio.textChunk.oid,
    });
    multipartRequest.headers.addAll(headers);
    final multipartFile =
        await _http.MultipartFile.fromPath('files', textAudio.audio.location);
    multipartRequest.files.add(multipartFile);
    final streamedResponse = await multipartRequest.send();
    final response = await _http.Response.fromStream(streamedResponse);
    print(response.body);
    if (response.statusCode != 200) throw FileUploadException();
  }

  @override
  Future<void> delete(ResetStatusRequest deleteRequest) async {
    final headers = await _apiHeaderProvider.getGeneralHeaderMapWithAuth();
    final response = await _http.post(Uri.parse(_delete_endpoint),
        body: deleteRequest.toJson(), headers: headers);
    if (response.statusCode != 200) throw DeleteFailedException();
  }
}
