import 'package:contacts/addData.dart';
import 'package:contacts/database.dart';
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
        color: Colors.cyanAccent,
        child: WatchBoxBuilder(box: Hive.box('database'), builder: (context,database){
          return ListView.builder(
            itemCount: database.length,
            itemBuilder: (context,index){
              final data=database.getAt(index) as Database; //returns our data as our class instan

              return Container(
                //display the features with your funcions n shit

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
