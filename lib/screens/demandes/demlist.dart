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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),
        ),
      ),
      body: FutureBuilder(
          future: demser.getData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: new CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    child: Container(child: Text(snapshot.data[index].type)),
                  );
                },
              );
            }
          },
        )
        
      );

  }


}