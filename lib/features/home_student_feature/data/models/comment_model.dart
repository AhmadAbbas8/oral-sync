class CommentModel {
  CommentModel({
    this.commentId,
    this.content,
    this.title,
    this.dateCreated,
    this.timeCreated,
    this.dateUpdated,
    this.timeUpdated,
    this.userId,
    this.postId,
    this.profileImage,
    this.user,
    this.post,
  });

  CommentModel.fromJson(dynamic json) {
    commentId = json['commentId'];
    content = json['content'];
    title = json['title'];
    dateCreated = json['dateCreated'];
    timeCreated = json['timeCreated'];
    dateUpdated = json['dateUpdated'];
    timeUpdated = json['timeUpdated'];
    userId = json['userId'];
    postId = json['postId'];
    user = json['user'];
    post = json['post'];
    profileImage = json['profileImage'];
  }

  num? commentId;
  String? content;
  String? title;
  String? dateCreated;
  String? timeCreated;
  String? profileImage;
  String? dateUpdated;
  String? timeUpdated;
  String? userId;
  num? postId;
  dynamic user;
  dynamic post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = commentId;
    map['content'] = content;
    map['title'] = title;
    map['dateCreated'] = dateCreated;
    map['timeCreated'] = timeCreated;
    map['dateUpdated'] = dateUpdated;
    map['timeUpdated'] = timeUpdated;
    map['userId'] = userId;
    map['postId'] = postId;
    map['user'] = user;
    map['post'] = post;
    return map;
  }
}
