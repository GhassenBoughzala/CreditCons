import 'dart:async';
import 'dart:convert';

import 'package:creditapp/screens/demandes/demdetail.dart';
import 'package:creditapp/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListDemandes extends StatefulWidget {
  @override
  _ListDemandesState createState() => _ListDemandesState();
}

class _ListDemandesState extends State<ListDemandes> {

  late List data;

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
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDashboardPage() ));
          },
          icon: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
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
                  style: TextStyle(fontSize: 25.0, color: Colors.blue),
                ),
               
              ),
            ),
          ),
        );
      },
        
      );
    }
  }