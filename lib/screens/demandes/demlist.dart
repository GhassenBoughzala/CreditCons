import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'demdetail.dart';

class demListPage extends StatefulWidget {
  @override
  _demListState createState() => _demListState();
}

class _demListState extends State<demListPage> {

  final List data = [] ;

  Future<List> getData() async {
    final response = await http.get("http://localhost:3000/viewall");
    return json.decode(response.body);
  }

  @override
  void initState() { 
    super.initState();
     this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews Products"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return new ItemList(list: data);
          } else {
            return new Center(
                  child: new CircularProgressIndicator(),
                );
          }
        },
      ),
      
    );
  }
}

  class ItemList extends StatelessWidget {

    final List list;
    ItemList({required this.list});


    @override
    Widget build(BuildContext context) {
      return new ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['type'].toString(),
                  style: TextStyle(fontSize: 25.0, color: Color(0xff3868B2)),
                ),
               
              ),
            ),
          ),
        );
      },
        
      );
    }
  }