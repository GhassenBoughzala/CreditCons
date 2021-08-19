import 'package:creditapp/main.dart';
import 'package:creditapp/screens/menu.dart';
import 'package:creditapp/services/authservice.dart';
import 'package:creditapp/services/demservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'button_widget.dart';
import 'package:intl/intl.dart';

final Color backgroundColor = Colors.white;

class AddDemPage extends StatefulWidget {

  AddDemPage({required Key key }) : super(key : key);
  @override
  AddDem createState() => AddDem();
}

class AddDem extends State<AddDemPage> with SingleTickerProviderStateMixin {

  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late SharedPreferences sharedPreferences;

  var type, period, name, token,duree, apport, montant, resultat, date;
  //var date = DateTime.now();
  /*
  String getText() {
    // ignore: unnecessary_null_comparison
    if (date == null) {
      return 'Select Date';
    } else {
      //return DateFormat('MM/dd/yyyy').format(date);
      return '${date.month}/${date.day}/${date.year}';
    }
  }
  */
  String dropdownvalue = 'Annuelle';

  DemService service = new DemService();

  @override
  void initState() {
    super.initState();
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
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddDemPage(key: token) ));},
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
                      TextButton(
                        child:  Text(" Logout ",                      
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,),
                        ),
                        onPressed: () async {
                        sharedPreferences = await SharedPreferences.getInstance();
                        AuthService().logout();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));},
                    ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    
                  ),
                  SizedBox(height: 20),
                  Text("Simulez votre credit", style: TextStyle(color: Color(0xff3868B2), fontSize: 20),),
                  Column(
                    children: <Widget>[
                      TextField(
                          decoration: InputDecoration(
                            labelText: 'Type'
                          ),
                          onChanged: (val){ type = val;},
                        ),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(labelText: 'Apport'),
                          onChanged: (val) { apport= val ; },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(labelText: 'Montant'),
                          onChanged: (val) { montant= val; },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(labelText: 'Resultat'),
                          onChanged: (val) { resultat= val; },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(labelText: 'Duree'),
                          onChanged: (val) { duree= val; },
                        ),
                        SizedBox(height: 10),
                        DropdownButton<String>(
                            value: dropdownvalue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 25,
                            elevation: 16,
                            style: TextStyle(color: Colors.blue),
                            underline: Container(
                              height:3,
                              color: Colors.blueAccent,
                            ),
                            onChanged: (val){ period = val;},
                            items: <String>["Mensuelle","Trimestrielle","Semestrielle","Annuelle"]
                            .map<DropdownMenuItem<String>>((String val){
                              // ignore: missing_required_param
                              return DropdownMenuItem<String>(
                                value: val = period,
                                child: Text(val),
                              );
                          }).toList(),
                        ),                    
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Date'),
                          onChanged: (val) { date= val; },
                        ),
                        
                        SizedBox(height: 10),
                    ],
                  ),
              Container(
                padding: EdgeInsets.only(top: 44.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: (){
                          service.addDem(
                            type, apport, montant, resultat, duree, period, date)
                          .then((val){                           
                            Fluttertoast.showToast(
                              msg:'Success',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDashboardPage()));
                          });
                        },
                  color: Color(0xff3868B2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                    "Simulez", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    ),
                  ),

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
/*
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
  */
}