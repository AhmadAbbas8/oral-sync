class RatingModel {
  // String? ratedUserId;
  // String? senderUserId;
  int? value;
  String? comment;
  String? dateCreated;
  String? timeCreated;

  RatingModel({
    // this.ratedUserId,
    // this.senderUserId,
    this.value,
    this.comment,
    this.dateCreated,
    this.timeCreated,
  });

  // Factory constructor to create a RatingModel object from JSON
  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      // ratedUserId: json['ratedUserId'],
      // senderUserId: json['senderUserId'],
      value: json['value'],
      comment: json['comment'],
      dateCreated: json['dateCreated'],
      timeCreated: json['timeCreated'],
    );
  }
}
