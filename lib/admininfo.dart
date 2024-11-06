// admininfo.dart
import 'package:flutter/material.dart';

class AdminInfoScreen extends StatelessWidget {
  const AdminInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          _buildCollegeSection(
            context,
            collegeName: 'College of Computer Studies',
            collegeLogo: 'assets/images/ccs_logo.jpg',
            deanName: 'Prof. Jesus S. Panguigan',
            deanPosition: 'Dean',
            deanContact: 'N/A',
            deanDescription: 'N/A',
            professors: [
              {
                'name': '',
                'position': '',
                'contact': '',
                'description': '',
              },
              {
                'name': '',
                'position': '',
                'contact': '',
                'description': '',
              },
              // Add more professors as needed
            ],
          ),
          _buildCollegeSection(
            context,
            collegeName: 'College of Engineering',
            collegeLogo: 'assets/images/coe_logo.jpg',
            deanName: '',
            deanPosition: '',
            deanContact: 'N/A',
            deanDescription: 'N/A',
            professors: [
              {
                'name': '',
                'position': '',
                'contact': '',
                'description': '',
              },
              {
                'name': '',
                'position': '',
                'contact': '',
                'description': '',
              },
              // Add more professors as needed
            ],
          ),
          // Add more colleges as needed
        ],
      ),
    );
  }

  Widget _buildCollegeSection(
    BuildContext context, {
    required String collegeName,
    required String collegeLogo,
    required String deanName,
    required String deanPosition,
    required String deanContact,
    required String deanDescription,
    required List<Map<String, String>> professors,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(collegeLogo),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        collegeName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(deanName),
                      Text(deanPosition),
                      Text(deanContact),
                      Text(
                        deanDescription,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            ExpansionTile(
              title: const Text(
                'Professors',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: professors.map((professor) {
                return ListTile(
                  title: Text(professor['name']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(professor['position']!),
                      Text(professor['contact']!),
                      Text(
                        professor['description']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
