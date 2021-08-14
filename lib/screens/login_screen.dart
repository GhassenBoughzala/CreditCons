import 'package:creditapp/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var name, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Email'
            ),
            onChanged: (val){ name = val;},
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
            onChanged: (val) { password = val; },
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            child: Text('Authenticate'),
            color: Colors.blue,
            onPressed: () {
              AuthService().login(name, password).then((val){
                token = val.data['token'];
                Fluttertoast.showToast(
                  msg:'Successfully Authenticated ',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              });
            }),            
            RaisedButton(
            child: Text('Sign up'),
            color: Colors.green,
            onPressed: () {
              AuthService().adduser(name, password).then((val){
                
                Fluttertoast.showToast(
                  msg: val.data['msg'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              });
            }),
            RaisedButton(
            child: Text('Get Infos'),
            color: Colors.green,
            onPressed: () {
              AuthService().getinfo(token).then((val){
                
                Fluttertoast.showToast(
                  msg: val.data['msg'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              });
            })
        ],
       ),
      ),
    );
  }
}