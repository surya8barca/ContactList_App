import 'package:contacts/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() => runApp(MaterialApp(
      home: Profile(),
    ));

class Profile extends StatefulWidget {
  final int index;
  Profile({this.index});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Profile> {
  final database = Hive.box('database');
  @override
  Widget build(BuildContext context) {
    final data = database.getAt(widget.index) as Database;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          '${data.name}',
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.cyanAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 550,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              image: DecorationImage(
                image: AssetImage('images/view.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 35,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name: ${data.name}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Age: ${data.age}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Phone Number: ${data.phone}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Email:\n${data.email}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
