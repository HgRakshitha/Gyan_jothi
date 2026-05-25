import 'dart:io';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart' show XFile;
import 'package:path_provider/path_provider.dart';

Future<List<XFile>> buildPngShareFilesIo(Uint8List bytes, String fileName) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes);
  return [XFile(file.path)];
}
