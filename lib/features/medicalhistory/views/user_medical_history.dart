import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/user_controller.dart';
import '../../../models/medical-history.dart';

class UserMedicalHistory extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final MedicalHistory medicalHistory = userController.medical.value!;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Medical Issues', Icons.health_and_safety),
                _buildMedicalIssuesTable(medicalHistory.medicalIssues),
                SizedBox(height: 16),
                _buildSectionHeader('Prescriptions', Icons.medical_services),
                _buildPrescriptionsTable(medicalHistory.prescriptions),
                SizedBox(height: 16),
                _buildSectionHeader('Appointments', Icons.calendar_today),
                _buildAppointmentsTable(medicalHistory.appointments),
                SizedBox(height: 16),
                _buildSectionHeader('Created At', Icons.access_time),
                _buildCreatedAtContainer(medicalHistory.createdAt),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalIssuesTable(List<MedicalIssue> issues) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        _buildTableHeader(['Condition', 'Severity', 'Notes', 'Start Date']),
        ...issues.map((issue) {
          return TableRow(children: [
            _buildTableCell(issue.condition),
            _buildTableCell(issue.severity),
            _buildTableCell(issue.notes),
            _buildTableCell(DateFormat('yyyy-MM-dd').format(issue.startDate)),
          ]);
        }).toList(),
      ],
    );
  }

  Widget _buildPrescriptionsTable(List<Prescription> prescriptions) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        _buildTableHeader(['Medication', 'Dosage', 'Start Date', 'End Date']),
        ...prescriptions.map((prescription) {
          return TableRow(children: [
            _buildTableCell(prescription.medicationName),
            _buildTableCell(prescription.dosage),
            _buildTableCell(
                DateFormat('yyyy-MM-dd').format(prescription.startDate)),
            _buildTableCell(prescription.endDate != null
                ? DateFormat('yyyy-MM-dd').format(prescription.endDate!)
                : 'N/A'),
          ]);
        }).toList(),
      ],
    );
  }

  Widget _buildAppointmentsTable(List<Appointment> appointments) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
      },
      children: [
        _buildTableHeader(['Doctor', 'Date', 'Notes']),
        ...appointments.map((appointment) {
          return TableRow(children: [
            _buildTableCell(appointment.doctorName),
            _buildTableCell(DateFormat('yyyy-MM-dd – kk:mm')
                .format(appointment.appointmentDate)),
            _buildTableCell(appointment.notes),
          ]);
        }).toList(),
      ],
    );
  }

  TableRow _buildTableHeader(List<String> headers) {
    return TableRow(
      children: headers.map((header) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            header,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCreatedAtContainer(DateTime createdAt) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        'Created At: ${DateFormat('yyyy-MM-dd – kk:mm').format(createdAt)}',
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
