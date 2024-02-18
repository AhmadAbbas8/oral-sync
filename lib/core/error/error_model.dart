class ErrorModel {
  ErrorModel({
    this.statusCode,
    this.messageEn,
    this.messageAr,
  });

  ErrorModel.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    messageEn = json['messageEn'];
    messageAr = json['messageAr'];
  }

  num? statusCode;
  String? messageEn;
  String? messageAr;
}
