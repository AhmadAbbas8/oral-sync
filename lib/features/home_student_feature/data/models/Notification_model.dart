class NotificationModel {
  NotificationModel({
    this.notificationId,
    this.sender,
    this.postId,
    this.type,
    this.isRead,
    this.dateCreated,
    this.timeCreated,
  });

  NotificationModel.fromJson(dynamic json) {
    notificationId = json['notificationId'];
    sender = json['sender'];
    postId = json['postId'];
    type = json['type'];
    isRead = json['isRead'];
    dateCreated = json['dateCreated'];
    timeCreated = json['timeCreated'];
  }

  num? notificationId;
  String? sender;
  num? postId;
  String? type;
  bool? isRead;
  String? dateCreated;
  String? timeCreated;
}
