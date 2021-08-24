import 'package:creditapp/screens/demandes/demlist.dart';
import 'package:creditapp/services/demservice.dart';
import 'package:flutter/material.dart';


class EditDem extends StatefulWidget {

  final List list;
  final int index;

  EditDem({required this.list, required this.index});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditDem> {

  //DataBaseHelper databaseHelper = new DataBaseHelper();

  late TextEditingController type;
  late TextEditingController apport;
  late TextEditingController montant;
  late TextEditingController resultat;
  late TextEditingController duree;
  late TextEditingController period;
  late TextEditingController date;
  late TextEditingController id;

  @override
  void initState() { 

    id= new TextEditingController(text: widget.list[widget.index]['_id'].toString() );
    type= new TextEditingController(text: widget.list[widget.index]['name'].toString() );
    apport= new TextEditingController(text: widget.list[widget.index]['apport'] );
    montant= new TextEditingController(text: widget.list[widget.index]['montant'] );
    resultat= new TextEditingController(text: widget.list[widget.index]['resultat'] );
    duree= new TextEditingController(text: widget.list[widget.index]['duree'] );
    period= new TextEditingController(text: widget.list[widget.index]['period'].toString() );
    date= new TextEditingController(text: widget.list[widget.index]['date'] );
    super.initState();
    
  }



  @override
  Widget build(BuildContext context) {
   return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit product"),
      ),
      body: Form(       
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: new TextFormField(
                      controller: id,
                          validator: (value) {
                            if (value!.isEmpty) return "ID";
                          },
                      decoration: new InputDecoration(
                        hintText: "Id", labelText: "Id",
                      ),
                    ),
                  ),
                 new ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: new TextFormField(
                      controller: type,
                          validator: (value) {
                            if (value!.isEmpty) return "type";
                          },
                      decoration: new InputDecoration(
                        hintText: "Type", labelText: "Type",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.black),
                    title: new TextFormField(
                      controller: apport,
                          validator: (value) {
                            if (value!.isEmpty) return "Apport";
                          },
                      decoration: new InputDecoration(
                        hintText: "Apport", labelText: "Apport",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component, color: Colors.black),
                    title: new TextFormField(
                      controller: montant,
                          validator: (value) {
                            if (value!.isEmpty) return "Montant";
                          },
                      decoration: new InputDecoration(
                        hintText: "Montant", labelText: "Montant",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component, color: Colors.black),
                    title: new TextFormField(
                      controller: resultat,
                          validator: (value) {
                            if (value!.isEmpty) return "Resultat";
                          },
                      decoration: new InputDecoration(
                        hintText: "Resultat", labelText: "Resultat",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component, color: Colors.black),
                    title: new TextFormField(
                      controller: duree,
                          validator: (value) {
                            if (value!.isEmpty) return "Duree";
                          },
                      decoration: new InputDecoration(
                        hintText: "Duree", labelText: "Duree",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component, color: Colors.black),
                    title: new TextFormField(
                      controller: period,
                          validator: (value) {
                            if (value!.isEmpty) return "Period";
                          },
                      decoration: new InputDecoration(
                        hintText: "Period", labelText: "Period",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.settings_input_component, color: Colors.black),
                    title: new TextFormField(
                      controller: date,
                          validator: (value) {
                            if (value!.isEmpty) return "Date";
                          },
                      decoration: new InputDecoration(
                        hintText: "Date", labelText: "Date",
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),                                    
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Edit"),
                    color: Colors.blueAccent,
                    onPressed: (){
                    DemService().editDem(id, type, apport, montant, resultat, duree, period, date);
                    Navigator.of(context)
                             .push(new MaterialPageRoute( 
                                  builder: (BuildContext context) => new demListPage()
                                   ),
                              );
                      },
                  
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}