class DoctorModel {
  Doctor? doctor;
  String? profileImage;
  String? name;
  num? averageRate;

  DoctorModel({
    this.doctor,
    this.profileImage,
    this.name,
    this.averageRate,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      profileImage: json['profileImage'],
      name: json['name'],
      averageRate: json['averageRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor?.toJson(),
      'profileImage': profileImage,
      'name': name,
      'averageRate': averageRate,
    };
  }
}

class Doctor {

  DoctorModel({
      this.doctorId, 
      this.firstName, 
      this.lastName, 
      this.isMale, 
      this.phoneNumber, 
      this.email, 
      this.universityName, 
      this.gpa, 
      this.clinicNumber, 
      this.clinicAddresses, 
      this.insuranceCompanies, 
      this.certificates, 
      this.graduationDate, 
      this.birthDate, 
      this.governorate, 
      this.userId, 
      this.user,});

  DoctorModel.fromJson(dynamic json) {
    doctorId = json['doctorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isMale = json['isMale'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    universityName = json['universityName'];
    gpa = json['gpa'];
    clinicNumber = json['clinicNumber'];
    clinicAddresses = json['clinicAddresses'] != null ? json['clinicAddresses'].cast<String>() : [];
    insuranceCompanies = json['insuranceCompanies'] != null ? json['insuranceCompanies'].cast<String>() : [];
    certificates = json['certificates'] != null ? json['certificates'].cast<String>() : [];
    graduationDate = json['graduationDate'];
    birthDate = json['birthDate'];
    governorate = json['governorate'];
    userId = json['userId'];
    user = json['user'];
  }
  num? doctorId;
  String? firstName;
  String? lastName;
  bool? isMale;
  String? phoneNumber;
  String? email;
  String? universityName;
  num? gpa;
  String? clinicNumber;
  List<String>? clinicAddresses;
  List<String>? insuranceCompanies;
  List<String>? certificates;
  String? graduationDate;
  String? birthDate;
  String? governorate;
  String? userId;
  dynamic user;
  Doctor({
    this.doctorId,
    this.firstName,
    this.lastName,
    this.isMale,
    this.phoneNumber,
    this.email,
    this.universityName,
    this.gpa,
    this.clinicNumber,
    this.clinicAddresses,
    this.insuranceCompanies,
    this.certificates,
    this.graduationDate,
    this.birthDate,
    this.governorate,
    this.userId,
    this.user,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctorId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      isMale: json['isMale'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      universityName: json['universityName'],
      gpa: json['gpa'],
      clinicNumber: json['clinicNumber'],
      clinicAddresses: json['clinicAddresses'] != null
          ? List<String>.from(json['clinicAddresses'])
          : null,
      insuranceCompanies: json['insuranceCompanies'] != null
          ? List<String>.from(json['insuranceCompanies'])
          : null,
      certificates: json['certificates'] != null
          ? List<String>.from(json['certificates'])
          : null,
      graduationDate: json['graduationDate'],
      birthDate: json['birthDate'],
      governorate: json['governorate'],
      userId: json['userId'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'firstName': firstName,
      'lastName': lastName,
      'isMale': isMale,
      'phoneNumber': phoneNumber,
      'email': email,
      'universityName': universityName,
      'gpa': gpa,
      'clinicNumber': clinicNumber,
      'clinicAddresses': clinicAddresses,
      'insuranceCompanies': insuranceCompanies,
      'certificates': certificates,
      'graduationDate': graduationDate,
      'birthDate': birthDate,
      'governorate': governorate,
      'userId': userId,
      'user': user,
    };
  }
}

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doctorId'] = doctorId;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['isMale'] = isMale;
    map['phoneNumber'] = phoneNumber;
    map['email'] = email;
    map['universityName'] = universityName;
    map['gpa'] = gpa;
    map['clinicNumber'] = clinicNumber;
    map['clinicAddresses'] = clinicAddresses;
    map['insuranceCompanies'] = insuranceCompanies;
    map['certificates'] = certificates;
    map['graduationDate'] = graduationDate;
    map['birthDate'] = birthDate;
    map['governorate'] = governorate;
    map['userId'] = userId;
    map['user'] = user;
    return map;
  }

}

