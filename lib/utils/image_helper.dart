import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../config/constants.dart';

class ImageHelper {
  // Compress image
  static Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: AppConstants.imageQuality,
      minWidth: AppConstants.maxImageWidth,
      minHeight: AppConstants.maxImageHeight,
      format: CompressFormat.jpeg,
    );

    return result != null ? File(result.path) : null;
  }

  // Check file size
  static Future<bool> isFileSizeValid(File file) async {
    final bytes = await file.length();
    final mb = bytes / (1024 * 1024);
    return mb <= AppConstants.maxPhotoSizeMB;
  }

  // Get file size in MB
  static Future<double> getFileSizeMB(File file) async {
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }
}
