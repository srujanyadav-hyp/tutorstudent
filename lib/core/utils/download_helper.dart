import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadHelper {
  static Future<void> downloadFile({
    required BuildContext context,
    required String url,
    required String fileName,
  }) async {
    try {
      // Show download progress
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Downloading...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Get the temporary directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Download the file
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);

      if (context.mounted) {
        // Show success message with option to open
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Download complete'),
            action: SnackBarAction(
              label: 'OPEN',
              onPressed: () async {
                // Open file using platform-specific method
                // This is a placeholder - implement platform-specific file opening
                debugPrint('Opening file: $filePath');
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

/// A provider for the DownloadHelper class
final downloadHelperProvider = Provider<DownloadHelper>((ref) {
  return DownloadHelper();
});
