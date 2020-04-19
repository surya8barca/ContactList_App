import 'package:contacts/addData.dart';
import 'package:contacts/database.dart';
import 'package:contacts/editData.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DatabaseAdapter());
  await Hive.openBox('database');
  runApp(MaterialApp(
    home: Home(),
)
);
} 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database= Hive.box('database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Contacts',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: WatchBoxBuilder(box: Hive.box('database'), builder: (context,database){
          return ListView.builder(
            itemCount: database.length,
            itemBuilder: (context,index){
              final data=database.getAt(index) as Database; //returns the data as our class instance

              return InkWell(
                onTap: (){
                  Alert(
                    context: context,
                    title: 'Options',
                    buttons: [],                    
                  ).show();
                },
                  child: Column(
                    children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.name,
                        ),
                        SizedBox(height: 5),
                        Text(
                          data.phone,
                        ),
                        SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton.icon(
                                onPressed: (){},
                                label: Text(
                                  'View',
                                  style: TextStyle(color: Colors.red)
                                ),
                                icon: Icon(Icons.remove_red_eye),
                              ),
                              FlatButton.icon(
                                onPressed: (){
                                  Route route = MaterialPageRoute(builder: (context)=> Edit(index:index));
                                  Navigator.push(context, route);
                                },
                                label: Text(
                                  'Edit ',
                                  style: TextStyle(color: Colors.red)
                                ),
                                icon: Icon(Icons.edit),
                              ),
                              FlatButton.icon(
                                onPressed: (){
                                  Alert(
                        context: context,
                        style: AlertStyle(
                          backgroundColor: Colors.cyan,
                        ),
                        title: "Delete",
                        desc: "Are you sure you want to delete ${data.name}?",
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
                                    database.deleteAt(index);
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
                                },
                                label: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red)
                                ),
                                icon: Icon(Icons.delete),
                              ),
                          ],
                        ),
                      ]
                      ),
                      ),
                    SizedBox(height: 3),
                  ],
                ),
              );
            }
          );
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Route route=MaterialPageRoute(builder: (context)=> Add());
          Navigator.push(context, route);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      );
  }
}
