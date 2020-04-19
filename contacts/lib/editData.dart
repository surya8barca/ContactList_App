import 'package:contacts/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(
      home: Edit(),
    ));

class Edit extends StatefulWidget {
  final int index;
  Edit({this.index});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Edit> {
  final database = Hive.box('database');
  TextEditingController forname = new TextEditingController();
  TextEditingController forage = new TextEditingController();
  TextEditingController forphone = new TextEditingController();
  TextEditingController foremail = new TextEditingController();

  String newname;
  int newage;
  String newphone;
  String newemail;

  validName(str) {
    if (str == '') {
      Alert(
              context: context,
              title: 'Invalid Name',
              desc: "Please Enter a valid name",
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else
      return true;
  }

  validAge(str) {
    if (int.parse(str) < 1 || int.parse(str) > 100) {
      Alert(
              context: context,
              title: 'Invalid Age',
              desc: "Please Enter a valid age\n(1 to 100)",
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else
      return true;
  }

  validPhone(str) {
    if (str.length != 10) {
      Alert(
              context: context,
              title: 'Invalid Phone Number',
              desc: "Please Enter a phone number\n(10 digits)",
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else
      return true;
  }

  validEmail(str) {
    Pattern emailType =
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex = new RegExp(emailType);
    if (!regex.hasMatch(str)) {
      Alert(
              context: context,
              title: 'Invalid Email Address',
              desc: "Please Enter a valid email address(example@site.domain)",
              buttons: [],
              style: AlertStyle(backgroundColor: Colors.cyan))
          .show();
      return false;
    } else
      return true;
  }

  getchanges(name, age, phone, email) {
    return Database(name, age, phone, email);
  }

  @override
  Widget build(BuildContext context) {
    final data = database.getAt(widget.index) as Database;
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          data.name,
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Details of ${data.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: forname,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Name: ${data.name}',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    helperText: '*reqiured',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      if (validName(value) &&
                          value != data.name &&
                          value != null) newname = value;
                    });
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: forage,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Age: ${data.age}',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    helperText: '*reqiured',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      if (validAge(value) &&
                          int.parse(value) != data.age &&
                          value != null) newage = int.parse(value);
                    });
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: forphone,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: 'Number: ${data.phone}',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    helperText: '*reqiured',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      if (validPhone(value) &&
                          value != data.phone &&
                          value != null) newphone = value;
                    });
                    FocusScope.of(context).unfocus();
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
                    labelText: 'Email: ${data.email}',
                    labelStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                    helperText: '*reqiured',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      if (validEmail(value) &&
                          value != data.email &&
                          value != null) newemail = value;
                    });
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              SizedBox(height: 20),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                minWidth: 50,
                height: 60,
                buttonColor: Colors.lightBlue,
                child: RaisedButton(
                  onPressed: () {
                    if (newname == null) newname = data.name;
                    if (newage == null) newage = data.age;
                    if (newemail == null) newemail = data.email;
                    if (newphone == null) newphone = data.phone;
                    Database changes =
                        getchanges(newname, newage, newphone, newemail);
                    setState(() {
                      database.putAt(widget.index, changes);
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save Changes',
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
    );
  }
}
