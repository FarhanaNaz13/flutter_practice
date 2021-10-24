import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class FileManager {
  Future<void> deleteFile(String path);
  Future<String> makeFilePermanent(String srcPath);
  Future<void> clearCache();
  Future<String> getTempFilePath();
}

class FileManagerImpl implements FileManager {
  @override
  Future<void> deleteFile(String path) async {
    await File(path).delete();
  }

  @override
  Future<String> makeFilePermanent(String srcPath) async {
    print('making permanent');
    final filename = srcPath.split('/').last;
    final permanentPath = await _getAppAudioFolderPath() + '/$filename';

    try {
      // prefer using rename as it is probably faster
      await File(srcPath).rename(permanentPath);
      // return permanentPath;
    } on FileSystemException catch (e) {
      // if rename fails, copy the source file and then delete it
      final newFile = await File(srcPath).copy(permanentPath);
      await File(srcPath).delete();
      // return permanentPath;
    }
    final file = File(permanentPath);
    print('file size' + (await file.length()).toString());
    return file.path;
  }

  @override
  Future<String> getTempFilePath() async {
    final path = await _getTempPathAtFolder(recorded);
    final filename = path +
        '/'
            'recording_' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp3';

    final file = await File(filename).create(recursive: true);
    return file.path;
  }

  @override
  Future<void> clearCache() async {
    final cacheDir = await getTemporaryDirectory();
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
  }

  static const recorded = 'recorded';

  Future<String> _getAppAudioFolderPath() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
      return _getAppAudioFolderPath();
    }
    final appDataPath = (await getApplicationDocumentsDirectory()).path;
    final audioFolder = Directory('$appDataPath/audio');
    if (!(await audioFolder.exists())) {
      await audioFolder.create();
    }
    return audioFolder.path;
  }

  Future<String> _getTempAppAudioFolderPath() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      await Permission.storage.request();
      return _getTempAppAudioFolderPath();
    }
    final appDataPath = (await getTemporaryDirectory()).path;
    final audioFolder = Directory('$appDataPath/audio');
    if (!(await audioFolder.exists())) {
      await audioFolder.create();
    }
    return audioFolder.path;
  }

  Future<String> _getTempPathAtFolder(String folderName) async {
    final path = await _getTempAppAudioFolderPath();
    final filename = path + '/' + folderName;
    final dir = Directory(filename);
    if (!await dir.exists()) {
      await dir.create();
    }
    return dir.path;
  }
}
