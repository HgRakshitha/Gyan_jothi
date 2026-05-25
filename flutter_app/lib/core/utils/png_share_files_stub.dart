import 'dart:typed_data';

import 'package:share_plus/share_plus.dart' show XFile;

Future<List<XFile>> buildPngShareFilesIo(Uint8List bytes, String fileName) async {
  return [
    XFile.fromData(bytes, mimeType: 'image/png', name: fileName),
  ];
}
