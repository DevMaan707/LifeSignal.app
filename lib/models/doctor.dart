class Doctor {
  String id;
  String firstName;
  String lastName;
  String speciality;
  String phone;
  String email;
  String clinicName;
  String clinicAddress;
  String profilePicture;
  double rating;
  int experience;
  List<String> availability;
  double fee;
  List<String> languages;
  List<String> qualifications;
  List<String> services;
  String about;
  Map<String, String> socialLinks;
  DateTime createdAt;

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
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      speciality: json['speciality'],
      phone: json['phone'],
      email: json['email'],
      clinicName: json['clinic_name'],
      clinicAddress: json['clinic_address'],
      profilePicture: json['profile_picture'],
      rating: (json['rating'] as num).toDouble(),
      experience: json['experience'],
      availability: List<String>.from(json['availability']),
      fee: (json['fee'] as num).toDouble(),
      languages: List<String>.from(json['languages']),
      qualifications: List<String>.from(json['qualifications']),
      services: List<String>.from(json['services']),
      about: json['about'],
      socialLinks: Map<String, String>.from(json['social_links']),
      createdAt: DateTime.parse(json['created_at']),
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
