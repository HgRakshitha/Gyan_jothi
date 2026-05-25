import 'dart:typed_data';

import 'package:share_plus/share_plus.dart' show XFile;

import 'png_share_files_stub.dart'
    if (dart.library.io) 'png_share_files_io.dart' as impl;

/// Builds [XFile]s for [Share.shareXFiles]. On IO, writes to a temp file
/// (more reliable on desktop); on web uses in-memory bytes.
Future<List<XFile>> buildPngShareFiles(Uint8List bytes, String fileName) =>
    impl.buildPngShareFilesIo(bytes, fileName);
