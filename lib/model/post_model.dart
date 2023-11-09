import 'dart:convert';

class PostModel {
  String id;
  String postTitle;
  String postDesc;
  String timeStamp;

  PostModel(
      {required this.id,
      required this.postTitle,
      required this.postDesc,
      required this.timeStamp});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      id: json["id"],
      postTitle: json["postTitle"],
      postDesc: json["postDesc"],
      timeStamp: json["timeStamp"]);

  Map<String, dynamic> toJosn() => {
        "id": id,
        "postTitle": postTitle,
        "postDesc": postDesc,
        "timeStamp": timeStamp
      };
}
