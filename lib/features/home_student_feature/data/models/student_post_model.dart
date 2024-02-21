class StudentPostModel {
  StudentPostModel({
    this.postId,
    this.title,
    this.content,
    this.dateCreated,
    this.dateUpdated,
    this.timeCreated,
    this.timeUpdated,
    this.userId,
    this.comments,
    this.likes,
    this.image,});

  StudentPostModel.fromJson(dynamic json) {
    postId = json['postId'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    timeCreated = json['timeCreated'];
    timeUpdated = json['timeUpdated'];
    userId = json['userId'];
    comments = json['comments'];
    likes = json['likes'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(v);
      });
    }
  }
  num? postId;
  String? title;
  String? content;
  String? dateCreated;
  String? dateUpdated;
  String? timeCreated;
  String? timeUpdated;
  String? userId;
  dynamic comments;
  dynamic likes;
  List<String>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = postId;
    map['title'] = title;
    map['content'] = content;
    map['dateCreated'] = dateCreated;
    map['dateUpdated'] = dateUpdated;
    map['timeCreated'] = timeCreated;
    map['timeUpdated'] = timeUpdated;
    map['userId'] = userId;
    map['comments'] = comments;
    map['likes'] = likes;
    if (image != null) {
      map['image'] = image;
    }
    return map;
  }

}