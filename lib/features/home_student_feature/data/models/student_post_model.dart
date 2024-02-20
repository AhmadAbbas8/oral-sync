class StudentPostModel {
  StudentPostModel({
    this.result,
    this.postImage,
  });

  StudentPostModel.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    postImage =
        json['postImage'] != null ? json['postImage'].cast<String>() : [];
  }

  List<Result>? result;
  List<String>? postImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['postImage'] = postImage;
    return map;
  }
}

class Result {
  Result({
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
  });

  Result.fromJson(dynamic json) {
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
    return map;
  }
}
