class StartMessageModel {
  int? messageId;
  Sender? sender;
  Receiver? receiver;

  StartMessageModel({this.messageId, this.sender, this.receiver});

  StartMessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    sender =
    json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? Receiver.fromJson(json['receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    return data;
  }
}

class Sender {
  String? id;
  String? name;
  String? profileImage;

  Sender({this.id, this.name, this.profileImage});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['senderId'];
    name = json['senderName'];
    profileImage = json['senderProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = id;
    data['senderName'] = name;
    data['senderProfileImage'] = profileImage;
    return data;
  }
}

class Receiver {
  String? id;
  String? name;
  String? profileImage;

  Receiver({this.id, this.name, this.profileImage});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['receiverId'];
    name = json['receiverName'];
    profileImage = json['receiverProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiverId'] = id;
    data['receiverName'] = name;
    data['receiverProfileImage'] = profileImage;
    return data;
  }
}
