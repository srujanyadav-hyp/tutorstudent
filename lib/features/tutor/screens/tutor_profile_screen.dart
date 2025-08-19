import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/providers/supabase_provider.dart';
import '../../../providers/role_provider.dart';
import '../../profile/providers/profile_provider.dart';
import '../widgets/tutor_scaffold.dart';
import '../widgets/pricing_plan_form.dart';

class TutorProfileScreen extends ConsumerStatefulWidget {
  const TutorProfileScreen({super.key});

  @override
  ConsumerState<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends ConsumerState<TutorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  bool _isEditing = false;
  final List<String> _selectedSubjects = [];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _qualificationsController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  void _loadProfileData() {
    final profile = ref.read(profileProvider).value;
    if (profile != null) {
      _nameController.text = profile.fullName;
      _phoneController.text = profile.phone ?? '';
      _bioController.text = profile.bio ?? '';

      if (profile.roleSpecificData != null) {
        _qualificationsController.text =
            profile.roleSpecificData!['qualifications']?.toString() ?? '';
        _hourlyRateController.text =
            profile.roleSpecificData!['hourly_rate']?.toString() ?? '';

        if (profile.roleSpecificData!['subjects'] != null) {
          _selectedSubjects.clear();
          _selectedSubjects.addAll(
            (profile.roleSpecificData!['subjects'] as List).cast<String>(),
          );
        }
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ref
            .read(profileProvider.notifier)
            .updateProfile(
              fullName: _nameController.text,
              phone: _phoneController.text,
              bio: _bioController.text,
              roleSpecificData: {
                'qualifications': _qualificationsController.text,
                'hourly_rate':
                    double.tryParse(_hourlyRateController.text) ?? 0.0,
                'subjects': _selectedSubjects.toList(),
              },
            );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() => _isEditing = false);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _loadProfileData();
      }
    });
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('New passwords do not match'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              try {
                await ref
                    .read(profileProvider.notifier)
                    .updatePassword(
                      currentPasswordController.text,
                      newPasswordController.text,
                    );

                if (!mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error updating password: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion feature coming soon!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final theme = Theme.of(context);
    final user = ref.watch(supabaseServiceProvider).client.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final profileAsync = ref.watch(profileProvider);

    return TutorScaffold(
      title: 'Profile',
      currentIndex: 4,
      actions: [
        if (_isEditing)
          IconButton(icon: const Icon(Icons.save), onPressed: _saveProfile),
        IconButton(
          icon: Icon(_isEditing ? Icons.close : Icons.edit),
          onPressed: _toggleEdit,
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await ref.read(supabaseServiceProvider).signOut();
            await ref.read(userRoleProvider.notifier).clearRole();
            if (context.mounted) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/login', (route) => false);
            }
          },
        ),
      ],
      body: SafeArea(
        child: profileAsync.when(
          data: (profile) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profile?.profileImage != null
                            ? NetworkImage(profile!.profileImage!)
                            : null,
                        child: profile?.profileImage == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: theme.primaryColor,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              try {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 512,
                                  maxHeight: 512,
                                  imageQuality: 75,
                                );

                                if (image != null) {
                                  await ref
                                      .read(profileProvider.notifier)
                                      .updateProfileImage(File(image.path));

                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Profile picture updated successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error updating profile picture: $e',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Information',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          if (_isEditing) ...[
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Full Name',
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _bioController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Bio',
                                prefixIcon: Icon(Icons.info_outline),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ] else ...[
                            ListTile(
                              leading: const Icon(Icons.person_outline),
                              title: const Text('Full Name'),
                              subtitle: Text(profile?.fullName ?? 'N/A'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: const Text('Email'),
                              subtitle: Text(profile?.email ?? 'N/A'),
                            ),
                            if (profile?.phone != null)
                              ListTile(
                                leading: const Icon(Icons.phone_outlined),
                                title: const Text('Phone'),
                                subtitle: Text(profile!.phone!),
                              ),
                            if (profile?.bio != null)
                              ListTile(
                                leading: const Icon(Icons.info_outline),
                                title: const Text('Bio'),
                                subtitle: Text(profile!.bio!),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Teaching Information',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        if (_isEditing) ...[
                          const Text('Subjects'),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children:
                                [
                                      'Mathematics',
                                      'Physics',
                                      'Chemistry',
                                      'Biology',
                                      'Computer Science',
                                      'English',
                                      'History',
                                      'Geography',
                                    ]
                                    .map(
                                      (subject) => FilterChip(
                                        label: Text(subject),
                                        selected: _selectedSubjects.contains(
                                          subject,
                                        ),
                                        onSelected: (selected) {
                                          setState(() {
                                            if (selected) {
                                              _selectedSubjects.add(subject);
                                            } else {
                                              _selectedSubjects.remove(subject);
                                            }
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _qualificationsController,
                            decoration: const InputDecoration(
                              labelText: 'Qualifications',
                              prefixIcon: Icon(Icons.grade_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _hourlyRateController,
                            decoration: const InputDecoration(
                              labelText: 'Hourly Rate (\$)',
                              prefixIcon: Icon(Icons.attach_money_outlined),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final rate = double.tryParse(value);
                                if (rate == null || rate < 0) {
                                  return 'Please enter a valid hourly rate';
                                }
                              }
                              return null;
                            },
                          ),
                        ] else ...[
                          if (profile?.roleSpecificData?['subjects'] != null)
                            ListTile(
                              leading: const Icon(Icons.school_outlined),
                              title: const Text('Subjects'),
                              subtitle: Text(
                                (profile!.roleSpecificData!['subjects'] as List)
                                    .join(', '),
                              ),
                            ),
                          if (profile?.roleSpecificData?['qualifications'] !=
                              null)
                            ListTile(
                              leading: const Icon(Icons.grade_outlined),
                              title: const Text('Qualifications'),
                              subtitle: Text(
                                profile!.roleSpecificData!['qualifications']
                                    .toString(),
                              ),
                            ),
                          if (profile?.roleSpecificData?['hourly_rate'] != null)
                            ListTile(
                              leading: const Icon(Icons.attach_money_outlined),
                              title: const Text('Hourly Rate'),
                              subtitle: Text(
                                '\$${profile!.roleSpecificData!['hourly_rate']}/hr',
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monthly Plans',
                              style: theme.textTheme.titleLarge,
                            ),
                            if (!_isEditing)
                              TextButton.icon(
                                onPressed: () {
                                  setState(() => _isEditing = true);
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit Plans'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        PricingPlanForm(tutorId: user.id),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (!_isEditing)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Settings',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.password_outlined),
                            title: const Text('Change Password'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              _showChangePasswordDialog(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.notifications_outlined),
                            title: const Text('Notification Settings'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Feature coming soon!'),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            title: const Text('Delete Account'),
                            subtitle: const Text(
                              'Permanently delete your account and data',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              _showDeleteAccountDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
