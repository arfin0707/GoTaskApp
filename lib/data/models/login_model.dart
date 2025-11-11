import 'package:task_manager_app_go_task/data/models/user_model.dart';
/*
class LoginModel {
  String? status;
  List<UserModel>? data;
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
    token = json['token'];
  }

  */
class LoginModel {
  bool status;       // ✅ boolean
  String token;    // ✅ message from PHP
  UserModel? data;   // ✅ single user

  LoginModel({
    required this.status,
    required this.token,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? false,
      token: json['token'] ?? '',
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}
/*
class LoginModel {
  String? status;
  String? token;
  UserModel? data; // single user, not a list

  LoginModel({this.status, this.token, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as String?,
      token: json['token'] as String?,
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}*/
/*
  class LoginModel {

  String? token;
  UserModel? data; // single user, not a list

  LoginModel({this.token, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] as String?,
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}
*/