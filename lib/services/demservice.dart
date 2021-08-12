import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DemService {

  Dio dio = new Dio();

  addDem(type, apport, montant,resultat, duree, period, date) async { 
      return await dio.post('http://localhost:3000/addDem',

          data: { "type": type,
                  "apport": apport,
                  "montant": montant,
                  "resultat": resultat,
                  "duree": duree,
                  "period": period,
                  "date": date},

          options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  viewall() async {
    return await dio.get('http://localhost:3000/viewall');
  }

  


}