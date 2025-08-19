import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class TutorResourceUploadScreen extends StatefulWidget {
  const TutorResourceUploadScreen({super.key});

  @override
  State<TutorResourceUploadScreen> createState() =>
      _TutorResourceUploadScreenState();
}

class _TutorResourceUploadScreenState extends State<TutorResourceUploadScreen> {
  bool _isUploading = false;
  String? _uploadStatus;

  Future<void> _pickAndUploadFile() async {
    setState(() {
      _isUploading = true;
      _uploadStatus = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final pickedFile = result.files.single;
        await _uploadFile(pickedFile);
      } else {
        setState(() {
          _uploadStatus = 'No file selected.';
        });
      }
    } catch (e) {
      setState(() {
        _uploadStatus = 'Error: $e';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _uploadFile(PlatformFile pickedFile) async {
    final supabase = Supabase.instance.client;
    final file = File(pickedFile.path!);

    // Create unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${timestamp}_${pickedFile.name}';

    try {
      // Upload to storage
      await supabase.storage.from('tutor-resources').upload(fileName, file);
      final fileUrl = supabase.storage
          .from('tutor-resources')
          .getPublicUrl(fileName);

      // Create learning material record
      final currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        final materialResponse = await supabase
            .from('learning_materials')
            .insert({
              'tutor_id': currentUser.id,
              'title': pickedFile.name,
              'description': 'Uploaded resource: ${pickedFile.name}',
              'file_url': fileUrl,
              'material_type': 'document',
              'subject': 'General',
              'grade_level': 'All',
            })
            .select()
            .single();

        // Grant access to all connected students
        await supabase.rpc(
          'grant_resource_access_to_all_students',
          params: {
            'p_resource_id': materialResponse['id'],
            'p_tutor_id': currentUser.id,
          },
        );

        setState(() {
          _uploadStatus = 'Upload successful! Shared with your students.';
        });
      }
    } catch (e) {
      setState(() {
        if (e.toString().contains('Bucket not found')) {
          _uploadStatus =
              'Storage bucket not found. Please run the database migration.';
        } else {
          _uploadStatus = 'Upload failed: $e';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Resource'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUploadArea(),
            const SizedBox(height: 20),
            if (_isUploading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Uploading...'),
            ],
            if (_uploadStatus != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _uploadStatus!.contains('successful')
                      ? Colors.green[50]
                      : Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _uploadStatus!,
                  style: TextStyle(
                    color: _uploadStatus!.contains('successful')
                        ? Colors.green[700]
                        : Colors.red[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUploadArea() {
    return GestureDetector(
      onTap: _isUploading ? null : _pickAndUploadFile,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Tap to upload a file',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your students will automatically get access',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
