import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = new Dio();

  login(email, password) async {
    try{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': password
    };
      return await dio.post(
      'http://localhost:3000/signin',
      data: {"email": email, "password":password},
      options: Options(contentType: Headers.formUrlEncodedContentType));

    }on DioError catch (e){
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

    }
  }

 signup(name,lastname,iban,email,password) async { 
      return await dio.post(
     'http://localhost:3000/signup',
      data: {
            "name": name,
            "lastname":lastname,
            "iban":iban,
            "email":email,
            "password":password},
      options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  getinfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('http://localhost:3000/getinfo');
  }

  logout() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await dio.get('http://localhost:3000/logout');
  }




}