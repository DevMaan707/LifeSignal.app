import 'package:flutter/material.dart';

import '../../../models/doctor.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${doctor.firstName} ${doctor.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(doctor.profilePicture),
            ),
            SizedBox(height: 16),
            Text(
              '${doctor.firstName} ${doctor.lastName}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              doctor.speciality,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text(doctor.phone),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text(doctor.email),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text(doctor.clinicAddress),
            ),
            Divider(),
            Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              doctor.about,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
