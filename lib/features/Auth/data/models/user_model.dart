import 'package:oralsync/features/Auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({super.flag, super.message, super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      flag: json['flag'], message: json['message'], token: json['token']);


}
