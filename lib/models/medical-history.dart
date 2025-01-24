class MedicalHistory {
  String id;
  String userId;
  List<MedicalIssue> medicalIssues;
  List<Prescription> prescriptions;
  List<Appointment> appointments;
  DateTime createdAt;

  MedicalHistory({
    required this.id,
    required this.userId,
    required this.medicalIssues,
    required this.prescriptions,
    required this.appointments,
    required this.createdAt,
  });
  factory MedicalHistory.fromJson(Map<String, dynamic> json) {
    return MedicalHistory(
      id: json['id'],
      userId: json['user_id'],
      medicalIssues: (json['medical_issues'] as List)
          .map((item) => MedicalIssue.fromJson(item))
          .toList(),
      prescriptions: (json['prescriptions'] as List)
          .map((item) => Prescription.fromJson(item))
          .toList(),
      appointments: (json['appointments'] as List)
          .map((item) => Appointment.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'medical_issues': medicalIssues.map((item) => item.toJson()).toList(),
      'prescriptions': prescriptions.map((item) => item.toJson()).toList(),
      'appointments': appointments.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class MedicalIssue {
  String condition;
  String severity;
  String notes;
  DateTime startDate;

  MedicalIssue({
    required this.condition,
    required this.severity,
    required this.notes,
    required this.startDate,
  });

  factory MedicalIssue.fromJson(Map<String, dynamic> json) {
    return MedicalIssue(
      condition: json['condition'],
      severity: json['severity'],
      notes: json['notes'],
      startDate: DateTime.parse(json['start_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition,
      'severity': severity,
      'notes': notes,
      'start_date': startDate.toIso8601String(),
    };
  }
}

class Prescription {
  String medicationName;
  String dosage;
  DateTime startDate;
  DateTime? endDate;

  Prescription({
    required this.medicationName,
    required this.dosage,
    required this.startDate,
    this.endDate,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      medicationName: json['medication_name'],
      dosage: json['dosage'],
      startDate: DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medication_name': medicationName,
      'dosage': dosage,
      'start_date': startDate.toIso8601String(),
      if (endDate != null) 'end_date': endDate!.toIso8601String(),
    };
  }
}

class Appointment {
  String doctorId;
  String doctorName;
  DateTime appointmentDate;
  String notes;

  Appointment({
    required this.doctorId,
    required this.doctorName,
    required this.appointmentDate,
    required this.notes,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorId: json['doctor_id'],
      doctorName: json['doctor_name'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'appointment_date': appointmentDate.toIso8601String(),
      'notes': notes,
    };
  }
}
