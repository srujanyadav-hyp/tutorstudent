import 'package:flutter/material.dart';

class TutorCard extends StatelessWidget {
  final Map<String, dynamic> tutor;

  const TutorCard({Key? key, required this.tutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: tutor['profile_image'] != null
              ? NetworkImage(tutor['profile_image'])
              : null,
          child: tutor['profile_image'] == null
              ? Text(tutor['full_name']?[0] ?? '?')
              : null,
        ),
        title: Text(tutor['full_name'] ?? 'Unknown'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (tutor['subjects'] as List?)?.join(', ') ?? 'No subjects listed',
            ),
            if (tutor['rating'] != null)
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(tutor['rating'].toString()),
                ],
              ),
          ],
        ),
        onTap: () {
          // Navigate to tutor details
        },
      ),
    );
  }
}
