import 'package:oralsync/features/Auth/domain/entities/register.dart';

class RegisterBodyModel extends RegisterBody {
  RegisterBodyModel({required super.flag, required super.message});

  factory RegisterBodyModel.fromJson(Map<String, dynamic> json) =>
      RegisterBodyModel(
        flag: json['flag'],
        message: json['message'],
      );
}
