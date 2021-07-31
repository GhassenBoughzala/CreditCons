 import 'package:flutter/material.dart';
 
 class HomeScreen extends StatefulWidget {
   @override
   _HomeScreenState createState() => _HomeScreenState();
 }
 
 class _HomeScreenState extends State<HomeScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 0,
         leading: IconButton(icon: Icon(Icons.dashboard_rounded), onPressed: null),
       ),
       
       body: Container(
         child: ListView(
           physics: ClampingScrollPhysics(),
           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(left:24, top: 8, bottom: 16),
               child: Text('Hello, User !',
               style: TextStyle(
                 fontFamily: 'Caviar',
                 fontSize: 25,
                 fontWeight: FontWeight.w700,
                 color: Colors.black,
               ),
               ),
               ),
            Center(
              child: Image(
                  image: AssetImage('Logo-03.png'),
                        width:300,
                        height:300
              ),
            ),
           ],
         ),
       )
     );
   }
 }