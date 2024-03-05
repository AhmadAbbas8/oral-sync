class NotificationModel {
  NotificationModel({
      this.notificationId, 
      this.senderUserId, 
      this.postId, 
      this.type, 
      this.isRead, 
      this.dateCreated, 
      this.timeCreated,});

  NotificationModel.fromJson(dynamic json) {
    notificationId = json['notificationId'];
    senderUserId = json['senderUserId'];
    postId = json['postId'];
    type = json['type'];
    isRead = json['isRead'];
    dateCreated = json['dateCreated'];
    timeCreated = json['timeCreated'];
  }
  num? notificationId;
  String? senderUserId;
  num? postId;
  String? type;
  bool? isRead;
  String? dateCreated;
  String? timeCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notificationId'] = notificationId;
    map['senderUserId'] = senderUserId;
    map['postId'] = postId;
    map['type'] = type;
    map['isRead'] = isRead;
    map['dateCreated'] = dateCreated;
    map['timeCreated'] = timeCreated;
    return map;
  }

}