import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class FileService {
  final _supabase = Supabase.instance.client;

  Future<String> uploadFile(File file, String fileName) async {
    try {
      final ext = path.extension(file.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final storagePath = 'chat_attachments/$timestamp$ext';

      await _supabase.storage.from('attachments').upload(storagePath, file);

      final fileUrl = _supabase.storage
          .from('attachments')
          .getPublicUrl(storagePath);

      return fileUrl;
    } catch (e) {
      throw 'Failed to upload file: ${e.toString()}';
    }
  }
}
