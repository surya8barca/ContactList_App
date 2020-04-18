
import 'package:contacts/database.dart';
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
  final database= Hive.box('database');
  TextEditingController forname=new TextEditingController();
  TextEditingController forage=new TextEditingController();
  TextEditingController forphone=new TextEditingController();
  TextEditingController foremail=new TextEditingController();
  String name;
  int age;
  String phone;
  String email;

  checkinvalid(){
    Pattern emailType= r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex= new RegExp(emailType);
    if(name==null||age==null||phone==null||email==null)
    {
      Alert(context: context,title: 'All fields are required',buttons: [],style: AlertStyle(backgroundColor:Colors.cyan)).show();
      return true;
    }
    else if(name=='')
    {
      Alert(context: context,title: 'Invalid Name',desc: "Please Enter a valid name",buttons: [],style: AlertStyle(backgroundColor:Colors.cyan)).show();
      return true;
    }
    else if(age<1||age>100)
    {
      Alert(context: context,title: 'Invalid Age',desc: "Please Enter a valid age\n(1 to 100)",buttons: [],style: AlertStyle(backgroundColor:Colors.cyan)).show();
      return true;
    }
    else if(phone.length!=10)
    {
      Alert(context: context,title: 'Invalid Phone Number',desc: "Please Enter a valid phone number\n(10 digits only)",buttons: [],style: AlertStyle(backgroundColor:Colors.cyan)).show();
      return true;
    }
    else if(!regex.hasMatch(email))
    {
      Alert(context: context,title: 'Invalid Email Address',desc: "Please Enter a valid email address(example@site.domain)",buttons: [],style: AlertStyle(backgroundColor:Colors.cyan)).show();
      return true;
    }
    else
      return false;
  }

  add(){
    Database newdata = Database(name, age, phone, email);
    database.add(newdata);
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
                    onSubmitted: (value){
                      setState(() {
                        name=value;  
                      });
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
                    onSubmitted: (value){
                      setState(() {
                        age=int.parse(value);  
                      });
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
                    onSubmitted: (value){
                      setState(() {
                        phone=value;  
                      });
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
                    onSubmitted: (value){
                      setState(() {
                        email=value;  
                      });
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
                  if(!checkinvalid())
                  {
                    Alert(
                    context: context,
                    style: AlertStyle(
                      backgroundColor: Colors.cyan,
                    ),
                    title: "Submit",
                    desc: "Are you sure you want to submit?",
                    buttons: [],
                    content: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            buttonColor: Colors.black,
                            child: RaisedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ButtonTheme(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            buttonColor: Colors.black,
                            child: RaisedButton(
                              onPressed: (){
                                add();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ).show();
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
