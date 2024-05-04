class DoctorModel {
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