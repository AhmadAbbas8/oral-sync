import 'package:oralsync/features/home_student_feature/data/models/comment_model.dart';

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
    this.likeCount,
    this.userName,
    this.image,
  });

  StudentPostModel.fromJson(dynamic json) {
    postId = json['postId'];
    title = json['title'];
    content = json['content'];
    userName = json['userName'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    timeCreated = json['timeCreated'];
    timeUpdated = json['timeUpdated'];
    userId = json['userId'];
    likeCount = json['likeCount'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(v);
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(CommentModel.fromJson(v));
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
  String? userName;
  List<CommentModel>? comments;
  num? likeCount;
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
    map['userName'] = userName;

    map['likeCount'] = likeCount;
    if (image != null) {
      map['image'] = image;
    }
    if (comments != null) {
      map['comments'] = comments;
    }
    return map;
  }
}
