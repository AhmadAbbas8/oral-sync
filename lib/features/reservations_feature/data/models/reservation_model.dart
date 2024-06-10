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
  final String? status;
  final String? location;
  final String? patientNotes;
  final String? doctorNotes;
  final String? paymentMethod;
  final num? fee;
  final DoctorReservationModel? user;

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
class DoctorReservationModel {
  final String? profileImage;
  final String? name;

  DoctorReservationModel({required this.profileImage, required this.name});
  factory DoctorReservationModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorReservationModelToJson(this);
}
