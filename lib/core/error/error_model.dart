class ResponseModel {
  ResponseModel({
    this.statusCode,
    this.messageEn,
    this.messageAr,
  });

  ResponseModel.fromJson(dynamic json) {
    statusCode = json['statusCode']??0;
    messageEn = json['messageEn']??'';
    messageAr = json['messageAr']??'';
  }

  num? statusCode;
  String? messageEn;
  String? messageAr;
}
