import 'package:creditapp/screens/menu.dart';
import 'package:creditapp/services/demservice.dart';
import 'package:flutter/material.dart';
class DemListPage extends StatelessWidget {
  DemService demser = new DemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: FutureBuilder(
          future: demser.getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: new CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index) {
                  //Container(child: Text(snapshot.data[index].type)),
                  return new Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(builder: 
                        (BuildContext context) => new DemListPage(


                        )),
                      ),
                    child: new Card(
                      child: new ListTile(
                        title: new Text(
                          snapshot.data[index].type,
                          style: TextStyle(fontSize: 25.0),
                        ),
                      )
                    ),
                    )
                  );
                },
              );
            }
          },
        )
        
      );

  }


}