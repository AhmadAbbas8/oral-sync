import 'package:oralsync/features/Auth/domain/entities/added.dart';

class AddedBodyModel extends AddedBody {
  AddedBodyModel({required super.message});

  factory AddedBodyModel.fromJson(Map<String, dynamic> json) => AddedBodyModel(
        message: json['message'],
      );
}
