// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.name,
    this.email,
    this.mobileNo,
    this.feedback,
  });

  String name;
  String email;
  String mobileNo;
  String feedback;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobileNo"],
    feedback: json["feedback"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobileNo": mobileNo,
    "feedback": feedback,
  };
}
