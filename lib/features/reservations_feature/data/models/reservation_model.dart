import 'package:json_annotation/json_annotation.dart';

part 'reservation_model.g.dart';

@JsonSerializable()
class ReservationModel {
  final int? id;
  final String? doctorId;
  final String? patientId;
  final String? dateCreated;
  final String? timeCreated;
  final String? timeAppointment;
  final String? dateAppointment;
  String? status;
  final String? location;
  final String? patientNotes;
  final String? doctorNotes;
  final String? paymentMethod;
  final num? fee;
  final UserReservationModel? user;

  ReservationModel(
      {this.id,
      this.doctorId,
      this.patientId,
      this.dateCreated,
      this.timeCreated,
      this.timeAppointment,
      this.dateAppointment,
      this.location,
      this.status,
      this.patientNotes,
      this.doctorNotes,
      this.paymentMethod,
      this.user,
      this.fee});

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}

@JsonSerializable()
class UserReservationModel {
  final String? profileImage;
  final String? name;
  final num? age;

  UserReservationModel({
    required this.profileImage,
    required this.name,
    required this.age,
  });

  factory UserReservationModel.fromJson(Map<String, dynamic> json) =>
      _$UserReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserReservationModelToJson(this);
}
