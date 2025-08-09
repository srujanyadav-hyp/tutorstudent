import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/providers/supabase_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/profile_info_form.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await ref
          .read(profileProvider.notifier)
          .updateProfileImage(File(pickedFile.path));
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset form when canceling edit
        _initializeControllers();
      }
    });
  }

  void _initializeControllers() {
    final profileAsync = ref.read(profileProvider);
    profileAsync.whenData((profile) {
      if (profile != null) {
        _nameController.text = profile.fullName;
        _phoneController.text = profile.phone ?? '';
        _bioController.text = profile.bio ?? '';
      }
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref
            .read(profileProvider.notifier)
            .updateProfile(
              fullName: _nameController.text,
              phone: _phoneController.text,
              bio: _bioController.text,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          _toggleEdit();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(supabaseServiceProvider).client.auth.signOut();
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('LOGOUT'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('No profile found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileImagePicker(
                  imageUrl: profile.profileImage,
                  onTap: _isEditing ? _pickImage : null,
                ),
                const SizedBox(height: 24),
                ProfileInfoForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  phoneController: _phoneController,
                  bioController: _bioController,
                  isEditing: _isEditing,
                  onSave: _saveProfile,
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Theme.of(context).primaryColor,
            size: 50,
          ),
        ),
        error: (error, stack) =>
            Center(child: Text('Error loading profile: $error')),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
              onPressed: _saveProfile,
              child: const Icon(Icons.save),
            )
          : null,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }
}
