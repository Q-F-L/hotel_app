import 'dart:convert';

MyFeedbackListModel myFeedbackListModelFromJson(String str) =>
    MyFeedbackListModel.fromJson(json.decode(str));

String myFeedbackListModelToJson(MyFeedbackListModel data) =>
    json.encode(data.toJson());

class MyFeedbackListModel {
  String? token;
  bool? status;
  String? error;

  MyFeedbackListModel({this.token, this.status, this.error});

  factory MyFeedbackListModel.fromJson(Map<String, dynamic> json) =>
      MyFeedbackListModel(
        token: json["token"],
        status: json["success"],
        error: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "success": status,
        "message": error,
      };
}
