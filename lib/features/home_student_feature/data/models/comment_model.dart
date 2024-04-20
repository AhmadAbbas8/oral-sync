class CommentModel {
  CommentModel({
    this.commentId,
    this.name,
    this.content,
    this.title,
    this.dateCreated,
    this.timeCreated,
    this.dateUpdated,
    this.timeUpdated,
    this.userId,
    this.postId,
    this.profileImage,
  });

  CommentModel.fromJson(dynamic json) {
    commentId = json['commentId'];
    name = json['name'];
    content = json['content'];
    title = json['title'];
    dateCreated = json['dateCreated'];
    timeCreated = json['timeCreated'];
    dateUpdated = json['dateUpdated'];
    timeUpdated = json['timeUpdated'];
    userId = json['userId'];
    postId = json['postId'];
    profileImage = json['profileImage']??'http://graduationprt22-001-site1.gtempurl.com/Profile/default/male.png';
  }

  num? commentId;
  String? name;
  String? content;
  String? title;
  String? dateCreated;
  String? timeCreated;
  String? dateUpdated;
  String? timeUpdated;
  String? userId;
  num? postId;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commentId'] = commentId;
    map['name'] = name;
    map['content'] = content;
    map['title'] = title;
    map['dateCreated'] = dateCreated;
    map['timeCreated'] = timeCreated;
    map['dateUpdated'] = dateUpdated;
    map['timeUpdated'] = timeUpdated;
    map['userId'] = userId;
    map['postId'] = postId;
    map['profileImage'] = profileImage;
    return map;
  }
}
