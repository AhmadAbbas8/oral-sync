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
  final String? status;
  final String? location;
  final String? patientNotes;
  final String? doctorNotes;
  final String? paymentMethod;
  final num? fee;

  ReservationModel(
      {this.id,
      this.doctorId,
      this.patientId,
      this.dateCreated,
      this.timeCreated,
      this.timeAppointment,
      this.status,
      this.location,
      this.patientNotes,
      this.doctorNotes,
      this.paymentMethod,
      this.fee});

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
