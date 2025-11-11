import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_app_go_task/app.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };
      // debugPrint(url);
      printRequest(url, null, headers);
      final Response response = await get(uri,headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      }else if(response.statusCode==401){
        _moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Unauthenticated!'
        );
/*        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodedData['message'] ??
              decodedData['error'] ??
              'Request failed with ${response.statusCode}',
        );*/
      }  else {
        /*        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );*/
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodedData['message'] ??
              decodedData['error'] ??
              'Request failed with ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      // debugPrint(url);
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if(response.statusCode==401){
        _moveToLogin();
         return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
           errorMessage: 'Unauthenticated!'
        );
/*        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodedData['message'] ??
              decodedData['error'] ??
              'Request failed with ${response.statusCode}',
        );*/
      } else {
        /* return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
        */
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:
              decodedData['message'] ??
              decodedData['error'] ??
              'Request failed with ${response.statusCode}',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  ) {
    debugPrint('REQUEST URL: $url\nBODY: $body}\nHEADERS:$headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY:${response.body}',
    );
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserDta();
    Navigator.pushAndRemoveUntil(
      TaskAManagerApp.navigatoKey.currentContext!,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (p) => false,
    );
  }
}
