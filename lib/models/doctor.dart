class Doctor {
  final String id;
  final String firstName;
  final String lastName;
  final String speciality;
  final String phone;
  final String email;
  final String clinicName;
  final String clinicAddress;
  final String profilePicture;
  final double rating;
  final int experience;
  final List<String> availability;
  final double fee;
  final List<String> languages;
  final List<String> qualifications;
  final List<String> services;
  final String about;
  final Map<String, String> socialLinks;
  final DateTime createdAt;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.speciality,
    required this.phone,
    required this.email,
    required this.clinicName,
    required this.clinicAddress,
    required this.profilePicture,
    required this.rating,
    required this.experience,
    required this.availability,
    required this.fee,
    required this.languages,
    required this.qualifications,
    required this.services,
    required this.about,
    required this.socialLinks,
    required this.createdAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      speciality: json['speciality'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      clinicName: json['clinic_name'] ?? "",
      clinicAddress: json['clinic_address'] ?? "",
      profilePicture: json['profile_picture'] ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      experience: json['experience'] ?? 0,
      availability: List<String>.from(json['availability'] ?? []),
      fee: (json['fee'] as num?)?.toDouble() ?? 0.0,
      languages: List<String>.from(json['languages'] ?? []),
      qualifications: List<String>.from(json['qualifications'] ?? []),
      services: List<String>.from(json['services'] ?? []),
      about: json['about'] ?? "",
      socialLinks: Map<String, String>.from(json['social_links'] ?? {}),
      createdAt:
          DateTime.tryParse(json['created_at'] ?? "") ?? DateTime(1970, 1, 1),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'speciality': speciality,
      'phone': phone,
      'email': email,
      'clinic_name': clinicName,
      'clinic_address': clinicAddress,
      'profile_picture': profilePicture,
      'rating': rating,
      'experience': experience,
      'availability': availability,
      'fee': fee,
      'languages': languages,
      'qualifications': qualifications,
      'services': services,
      'about': about,
      'social_links': socialLinks,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<Doctor> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Doctor.fromJson(json)).toList();
  }
}
