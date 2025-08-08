import 'package:flutter/material.dart';
import '../../auth/widgets/custom_text_form_field.dart';

class ProfileInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final bool isEditing;
  final VoidCallback onSave;

  const ProfileInfoForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
    required this.bioController,
    required this.isEditing,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: nameController,
            label: 'Full Name',
            hint: 'Enter your full name',
            enabled: isEditing,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            enabled: isEditing,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: bioController,
            label: 'Bio',
            hint: 'Tell us about yourself',
            enabled: isEditing,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
