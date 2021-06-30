import 'package:flutter/material.dart';
import 'thirdscreen.dart';


class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

enum choice { kitchen, living_room, bedroom, bath }

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static String option1;
  choice _site;
  bool nextchoice = false;

  showAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please make a choice."),
    );
    TextButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text('OK'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[

        ListTile(),
        ListTile(
          title: const Text('study room',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.bedroom,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice = true;
                option1='study room';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('bath',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.bath,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='bath';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('living room',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.living_room,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='living room';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('kitchen',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.kitchen,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='kitchen';
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              child: RaisedButton.icon(
                onPressed: (){
                  if(nextchoice){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>landingscreen()),
                    );
                  }
                  else {
                    showAlertDialog();
                  }
                },
                icon: Icon(Icons.navigate_next_rounded),
                label: Text('NEXT'),
                color: Colors.white,
              )
          ),
        ),
      ],
    );
  }
}