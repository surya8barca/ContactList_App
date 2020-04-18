import 'package:contacts/database.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Scaffold(

      ),
    );
  }
}
