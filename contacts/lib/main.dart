import 'package:contacts/addData.dart';
import 'package:contacts/database.dart';
import 'package:contacts/editData.dart';
import 'package:contacts/viewData.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DatabaseAdapter());
  await Hive.openBox('database');
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final database = Hive.box('database');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
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
        child: WatchBoxBuilder(
          box: Hive.box('database'),
          builder: (context, database) {
            if ((database.length == 0)) {
              return Container(
                  height: 560,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/originals/0a/a8/bf/0aa8bfa73e2f93d3816b75bbd1b4a95a.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text(
                      'Empty Database\nPlease Add Some Data!!\n\n\n\n\n\n\n\nClick on this Button to add new \nContacts -->',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      )));
            } else {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/0a/a8/bf/0aa8bfa73e2f93d3816b75bbd1b4a95a.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                    itemCount: database.length,
                    itemBuilder: (context, index) {
                      final data = database.getAt(index)
                          as Database; //returns the data as our class instance

                      return InkWell(
                        onTap: () {
                          Alert(
                              context: context,
                              title: '${data.name}',
                              buttons: [],
                              style: AlertStyle(
                                  backgroundColor: Colors.transparent,
                                  titleStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  )),
                              content: Column(
                                children: <Widget>[
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          launch("tel: ${data.phone}");
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          size: 60,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(width: 35),
                                      IconButton(
                                        onPressed: () {
                                          launch("sms: ${data.phone}");
                                        },
                                        icon: Icon(
                                          Icons.message,
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 35),
                                      IconButton(
                                        onPressed: () {
                                          launch("mailto: ${data.email}");
                                        },
                                        icon: Icon(
                                          Icons.email,
                                          size: 60,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ],
                              )).show();
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.yellow),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(data.name,
                                        style: TextStyle(
                                          color: Colors.cyan,
                                          fontSize: 25,
                                        )),
                                    SizedBox(height: 5),
                                    Text(
                                      data.phone,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FlatButton.icon(
                                          onPressed: () {
                                            Route route = MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile(index: index));
                                            Navigator.push(context, route);
                                          },
                                          label: Text('View',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          ),
                                        ),
                                        FlatButton.icon(
                                          onPressed: () {
                                            Route route = MaterialPageRoute(
                                                builder: (context) =>
                                                    Edit(index: index));
                                            Navigator.push(context, route);
                                          },
                                          label: Text('Edit ',
                                              style: TextStyle(
                                                  color: Colors.green)),
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        FlatButton.icon(
                                          onPressed: () {
                                            Alert(
                                              context: context,
                                              style: AlertStyle(
                                                backgroundColor:
                                                    Colors.transparent,
                                                titleStyle: TextStyle(
                                                    color: Colors.white),
                                                descStyle: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              title: "Delete",
                                              desc:
                                                  "Are you sure you want to delete ${data.name}?",
                                              buttons: [],
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    ButtonTheme(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      buttonColor: Colors.white,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ButtonTheme(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      buttonColor: Colors.white,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          database
                                                              .deleteAt(index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Yes',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ).show();
                                          },
                                          label: Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      );
                    }),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => Add());
            Navigator.push(context, route);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.cyan),
    );
  }
}
