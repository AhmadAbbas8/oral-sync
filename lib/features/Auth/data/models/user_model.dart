class UserModel {
  final String? token;
  final String? profileImage;
  final String? userRole;
  final UserDetails? userDetails;
  final num? averageRate;

  UserModel({
    required this.token,
    required this.profileImage,
    required this.userRole,
    required this.userDetails,
    this.averageRate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String userRole = json['userRole'] ?? 'Student';
    UserDetails userDetails;

    switch (userRole) {
      case 'Patient':
        userDetails = PatientDetails.fromJson(json['userDetails']);
        break;
      case 'Doctor':
        userDetails = DoctorDetails.fromJson(json['userDetails']);
        break;
      case 'Student':
        userDetails = StudentDetails.fromJson(json['userDetails']);
        break;
      default:
        throw Exception('Unknown user role');
    }

    return UserModel(
      token: json['token'],
      profileImage: json['profileImage'],
      averageRate: json['averageRate'],
      userRole: userRole,
      userDetails: userDetails,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'profileImage': profileImage,
        'userRole': userRole,
        'averageRate': averageRate,
        'userDetails': userDetails?.toJson(),
      };
}

class UserDetails {
  final String? firstName;
  final String? lastName;
  final bool? isMale;
  final String? phoneNumber;
  final String? email;
  final String? birthDate;
  final String? governorate;
  final String? userId;

  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.isMale,
    required this.phoneNumber,
    required this.email,
    required this.birthDate,
    required this.governorate,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'isMale': isMale,
        'phoneNumber': phoneNumber,
        'email': email,
        'birthDate': birthDate,
        'governorate': governorate,
        'userId': userId,
      };
}

class PatientDetails extends UserDetails {
  final List<String>? address;
  final String? insuranceCompany;

  PatientDetails({
    required String firstName,
    required String lastName,
    required bool isMale,
    required String phoneNumber,
    required String email,
    required String birthDate,
    required String governorate,
    required String userId,
    required this.address,
    required this.insuranceCompany,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          isMale: isMale,
          phoneNumber: phoneNumber,
          email: email,
          birthDate: birthDate,
          governorate: governorate,
          userId: userId,
        );

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['address'] = address;
    json['insuranceCompany'] = insuranceCompany;
    return json;
  }

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      firstName: json['firstName'],
      governorate: json['governorate'],
      lastName: json['lastName'],
      isMale: json['isMale'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      birthDate: json['birthDate'],
      address: List<String>.from(json['address'] ?? []),
      insuranceCompany: json['insuranceCompany'],
      userId: json['userId']??'',
    );
  }
}

class DoctorDetails extends UserDetails {
  final String? universityName;
  final String? clinicNumber;
  final List<String?>? clinicAddress;
  final List<String?>? insuranceCompanies;
  final List<String?>? certificates;
  final String? graduationDate;
  final num? gpa;

  DoctorDetails({
    required String firstName,
    required String lastName,
    required bool isMale,
    required String phoneNumber,
    required String email,
    required String birthDate,
    required String governorate,
    required String userId,
    required this.gpa,
    required this.universityName,
    required this.clinicNumber,
    required this.clinicAddress,
    required this.insuranceCompanies,
    required this.certificates,
    required this.graduationDate,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          isMale: isMale,
          phoneNumber: phoneNumber,
          email: email,
          birthDate: birthDate,
          governorate: governorate,
          userId: userId,
        );

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['universityName'] = universityName;
    json['clinicNumber'] = clinicNumber;
    json['clinicAddresses'] = clinicAddress;
    json['insuranceCompanies'] = insuranceCompanies;
    json['certificates'] = certificates;
    json['graduationDate'] = graduationDate;
    json['gpa'] = gpa;
    return json;
  }

  factory DoctorDetails.fromJson(Map<String, dynamic> json) {
    return DoctorDetails(
      firstName: json['firstName'],
      gpa: json['gpa'],
      lastName: json['lastName'],
      isMale: json['isMale'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      userId: json['userId']??'',
      governorate: json['governorate'],
      birthDate: json['birthDate'],
      universityName: json['universityName'],
      clinicNumber: json['clinicNumber'],
      clinicAddress: List<String>.from(json['clinicAddresses'] ?? []),
      insuranceCompanies: List<String>.from(json['insuranceCompanies'] ?? []),
      certificates: List<String>.from(json['certificates'] ?? []),
      graduationDate: json['graduationDate'],
    );
  }
}

class StudentDetails extends UserDetails {
  final String? universityName;
  final List<String?>? universityAddress;
  final num? gpa;
  final num? academicYear;

  StudentDetails({
    required String firstName,
    required String lastName,
    required bool isMale,
    required String phoneNumber,
    required String email,
    required String birthDate,
    required String governorate,
    required String userId,
    required this.universityName,
    required this.universityAddress,
    required this.gpa,
    required this.academicYear,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          governorate: governorate,
          isMale: isMale,
          phoneNumber: phoneNumber,
          email: email,
          birthDate: birthDate,
          userId: userId,
        );

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['universityName'] = universityName;
    json['universitAddress'] = universityAddress;
    json['gpa'] = gpa;
    json['academicYear'] = academicYear;
    return json;
  }

  factory StudentDetails.fromJson(Map<String, dynamic> json) {
    return StudentDetails(
      firstName: json['firstName'],
      lastName: json['lastName'],
      isMale: json['isMale'],
      governorate: json['governorate'] ?? '',
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      birthDate: json['birthDate'],
      universityName: json['universityName'],
      universityAddress: List<String>.from(json['universitAddress'] ?? []),
      gpa: json['gpa'],
      academicYear: json['academicYear'],
      userId: json['userId']??'',
    );
  }
}
