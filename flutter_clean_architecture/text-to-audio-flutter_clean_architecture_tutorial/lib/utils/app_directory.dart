import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const recorded = 'recorded';
const reviewed = 'reviewed';

Future<String> getAppAudioFolderPath() async {
  final status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    await Permission.storage.request();
    return getAppAudioFolderPath();
  }
  final appDataPath = (await getApplicationDocumentsDirectory()).path;
  final audioFolder = Directory('$appDataPath/audio');
  if (!(await audioFolder.exists())) {
    await audioFolder.create();
  }
  return audioFolder.path;
}

Future<String> getPathForNewAudioFile() async {
  final path = await getRecordedFolderPath();
  final filename = path +
      '/'
          'recording_' +
      DateTime.now().millisecondsSinceEpoch.toString() +
      '.mp3';

  final file = await File(filename).create(recursive: true);
  return file.path;
}

Future<String> getRecordedFolderPath() async {
  return _getPathAtFolder(recorded);
}

Future<String> getReviewedFolderPath() async {
  return _getPathAtFolder(reviewed);
}

Future<String> _getPathAtFolder(String folderName) async {
  final path = await getAppAudioFolderPath();
  final filename = path + '/' + folderName;
  final dir = Directory(filename);
  if (!await dir.exists()) {
    await dir.create();
  }
  return dir.path;
}
