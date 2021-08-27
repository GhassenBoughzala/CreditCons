import 'dart:convert';

import 'package:creditapp/main.dart';
import 'package:creditapp/screens/demandes/Adddem.dart';
import 'package:creditapp/services/authservice.dart';
import 'package:creditapp/services/demservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../menu.dart';
import 'demdetail.dart';
import 'demlist.dart';

final Color backgroundColor = Colors.white;

class ListDemViewPage extends StatefulWidget {
  @override
  ListDemView createState() => ListDemView();
}

class ListDemView extends State<ListDemViewPage> with SingleTickerProviderStateMixin {

  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late SharedPreferences sharedPreferences;

  var type, period, name, token,duree, apport, montant, resultat;
  var date = DateTime.now();

  late Map data;
  late List demData = [];

  Future<List> getData() async {
    final response = await http.get("http://localhost:3000/viewall");
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                        child:  Text("Dashboard", style: TextStyle(color: Color(0xff3868B2), fontSize: 22)),
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDashboardPage() ));},
                    ),
                SizedBox(height: 10),
                TextButton(
                        child:  Text("Simuler Credit", style: TextStyle(color: Color(0xff3868B2), fontSize: 22)),
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddDemPage(key: token,) ));},
                    ),
                SizedBox(height: 10),
                TextButton(
                        child:  Text("List de Credits", style: TextStyle(color: Color(0xff3868B2), fontSize: 22)),
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DemListPage() ));},
                    ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Color(0xff3868B2)),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("", style: TextStyle(fontSize: 24, color: Color(0xff3868B2))),
                      IconButton(
                        icon: Icon(Icons.logout, color: Color(0xff3868B2)),
                        onPressed: () async {
                        sharedPreferences = await SharedPreferences.getInstance();
                        AuthService().logout();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                        },
                      ), 
                    ],
                  ),
                  SizedBox(height: 50),
                               
              Scaffold(
                body: ListView.builder(
                    itemCount: demData == null ? 0 : demData.length,
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Text("${demData[index]["_id"]}", style: TextStyle(fontSize: 24, color: Color(0xff3868B2))),
                          ],
                        ),
                      );
                    },
                  ),     

              )
                ],
              ),
            ),
            
            
          ),
        ),
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