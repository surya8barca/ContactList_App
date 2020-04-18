import 'package:contacts/database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'addData.dart';

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
  final databse= Hive.box('database');
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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            
          ),
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
