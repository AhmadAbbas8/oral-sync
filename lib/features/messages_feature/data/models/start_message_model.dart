class StartMessageModel {
  int? id;
  Sender? sender;
  Sender? receiver;

  StartMessageModel({this.id, this.sender, this.receiver});

  StartMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver =
    json['receiver'] != null ? new Sender.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
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
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
