

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(
  home: Add(),
)
);

class Add extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Add> {
  final databse= Hive.box('database');
  TextEditingController forname=new TextEditingController();
  TextEditingController forage=new TextEditingController();
  TextEditingController forphone=new TextEditingController();
  TextEditingController foremail=new TextEditingController();
  String name;
  int age;
  String phone;
  String email;

  emptyfields(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Add Data',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
              child: Center(
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Enter contact details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: forname,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Enter name:',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      helperText: '*reqiured',
                    ),
                    onSubmitted: (name){
                      name=name;
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: forage,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Enter age:',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      helperText: '*reqiured',
                    ),
                    onSubmitted: (age){
                      age=age;
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: forphone,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Enter Mobile Number:',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      helperText: '*reqiured',
                    ),
                    onSubmitted: (number){
                      phone=number;
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: foremail,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      labelText: 'Enter email address:',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      helperText: '*reqiured',
                    ),
                    onSubmitted: (email){
                      email=email;
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                SizedBox(height: 20),
                ButtonTheme(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30)
              ),
                minWidth: 50,
                height: 60,
                buttonColor: Colors.lightBlue,
                child: RaisedButton(
                onPressed: (){
                  if(emptyfields())
                  {
                    Alert(context: context,title: 'Empty Fields',desc: 'Please Enter all the fields properly',buttons: [],style: AlertStyle(backgroundColor: Colors.black));
                  }
                  else
                  {
                    //ask for submit confirmation
                    //call the add function and navigate out
                  }

                }, 
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            ],
            ),
          ),
        ),
      )
    );
  }
}
