import 'dart:io';
import 'package:path_provider/path_provider.dart';

const androidDownloadDir = "/storage/emulated/0/Download";

class FileUtil {
  static Directory? _downloadDir;

  static Future<Directory?> getDownloadDirectory() async {
    if (_downloadDir != null) return _downloadDir;

    if (Platform.isAndroid) {
      final dir = Directory(androidDownloadDir);

      if (await dir.exists()) {
        _downloadDir = dir;
        
        return _downloadDir;
      }
    }

    _downloadDir = await getApplicationDocumentsDirectory();

    return _downloadDir;
  }
}
