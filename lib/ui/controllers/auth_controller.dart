import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app_go_task/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey ='access-token';
  static const String _userdataKey ='user-data';

  static String? accessToken;
  // static UserModel? userData;

  // 👇 Wrap userData in a ValueNotifier (reactive)
  static final ValueNotifier<UserModel?> userDataNotifier = ValueNotifier<UserModel?>(null);
  static UserModel? get userData => userDataNotifier.value;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken= token;
  }


  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userdataKey, jsonEncode(userModel.toJson()));
    // userData= userModel;
    // 👇 update both static + reactive version
    userDataNotifier.value = userModel;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token= sharedPreferences.getString(_accessTokenKey);
    accessToken =token;
    return token;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedData= sharedPreferences.getString(_userdataKey);
    if(userEncodedData == null){
      return null;
    }

    UserModel userModel =UserModel.fromJson(jsonDecode(userEncodedData));
   // userData=userModel;

    userDataNotifier.value = userModel; // 👈 this updates listeners
    return userModel;
    // UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedData));
    // userData = userModel;
    // return userModel;
  }


  static bool isloggedIn(){
    return accessToken!=null;
  }
/*  static Future<void> clearUserDta() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken=null;
  }*/

  static Future<void> clearUserDta() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_userdataKey);
    accessToken = null;
    // userData = null;
    //👇
    userDataNotifier.value = null;

  }

}
