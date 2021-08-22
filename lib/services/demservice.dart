import 'package:dio/dio.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DemService {

  Dio dio = new Dio();
  var status;
  var token;

addDem(type, apport, montant,resultat, duree, period, date) async { 

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

          return await dio.post('http://localhost:3000/addDem',

          data: { "type": type,
                  "apport": apport,
                  "montant": montant,
                  "resultat": resultat,
                  "duree": duree,
                  "period": period,
                  "date": date},

          options: Options(contentType: Headers.formUrlEncodedContentType));



/*
      String myUrl = "http://192.168.1.56:3000/addDem";
      final response = await  http.post(myUrl,
            headers: {
              'Accept':'application/json'
            },
            body: {
                  "type": "$type",
                  "apport": "$status",
                  "montant": "$montant",
                  "resultat": "$resultat",
                  "duree": "$duree",
                  "period": "$period",
                  "date": "$date"
            } ) ;
        status = response.body.contains('error');

        var data = json.decode(response.body);

        if(status){
          print('data : ${data["error"]}');
        }else{
          print('data : ${data["token"]}');
          _save(data["token"]);
        }
*/

  }


//function save
_save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

//function read
read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }
 


}