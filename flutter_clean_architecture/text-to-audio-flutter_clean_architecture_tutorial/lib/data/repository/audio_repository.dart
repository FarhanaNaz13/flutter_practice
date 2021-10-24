import 'package:text_to_audio/data/exception/current_audio_not_found_exception.dart';
import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/data/source/local/file_manager.dart';

abstract class AudioRepository {
  Future<Audio> getCurrentAudio();
  Future<void> setCurrentAudio(Audio audio);
  Future<void> clearCurrentAudio();
  Future<void> deleteAudio(Audio audio);
  Future<String> getNewAudioPath();
  Future<void> moveAudioToPermanentFolder(Audio audio);
}

class AudioRepositoryImpl implements AudioRepository {
  final FileManager _fileManager;
  Audio? _audio;

  AudioRepositoryImpl(this._fileManager);
  @override
  Future<void> clearCurrentAudio() async {
    _audio = null;
  }

  @override
  Future<Audio> getCurrentAudio() async {
    if (_audio == null) throw CurrentAudioNotFoundException();
    return _audio!;
  }

  @override
  Future<void> setCurrentAudio(Audio audio) async {
    _audio = audio;
  }

  @override
  Future<void> deleteAudio(Audio audio) async {
    if (audio == _audio) _audio = null;
    await _fileManager.deleteFile(audio.location);
  }

  @override
  Future<String> getNewAudioPath() => _fileManager.getTempFilePath();

  @override
  Future<void> moveAudioToPermanentFolder(Audio audio) async {
    print('hola');
    audio.location = await _fileManager.makeFilePermanent(audio.location);
  }
}
