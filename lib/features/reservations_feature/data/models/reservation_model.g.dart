// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      id: (json['id'] as num?)?.toInt(),
      doctorId: json['doctorId'] as String?,
      patientId: json['patientId'] as String?,
      dateCreated: json['dateCreated'] as String?,
      timeCreated: json['timeCreated'] as String?,
      timeAppointment: json['timeAppointment'] as String?,
      dateAppointment: json['dateAppointment'] as String?,
      location: json['location'] as String?,
      status: json['status'] as String?,
      patientNotes: json['patientNotes'] as String?,
      doctorNotes: json['doctorNotes'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      user: json['user'] == null
          ? null
          : UserReservationModel.fromJson(json['user'] as Map<String, dynamic>),
      isRating: json['isRating'] as bool?,
      fee: json['fee'] as num?,
    );

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'dateCreated': instance.dateCreated,
      'timeCreated': instance.timeCreated,
      'timeAppointment': instance.timeAppointment,
      'dateAppointment': instance.dateAppointment,
      'status': instance.status,
      'location': instance.location,
      'patientNotes': instance.patientNotes,
      'doctorNotes': instance.doctorNotes,
      'paymentMethod': instance.paymentMethod,
      'fee': instance.fee,
      'user': instance.user,
      'isRating': instance.isRating,
    };

UserReservationModel _$UserReservationModelFromJson(
        Map<String, dynamic> json) =>
    UserReservationModel(
      profileImage: json['profileImage'] as String?,
      name: json['name'] as String?,
      age: json['age'] as num?,
    );

Map<String, dynamic> _$UserReservationModelToJson(
        UserReservationModel instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'name': instance.name,
      'age': instance.age,
    };
