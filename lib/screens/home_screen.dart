import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motogp/screens/add.dart';
import 'package:motogp/screens/filter.dart';
import 'package:motogp/screens/search.dart';
import 'package:motogp/screens/view.dart';

import '../controller/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color buttonColor = Color(0xff25bcbb);

  final user = FirebaseAuth.instance.currentUser!;
  Database? db;
  List docs = [];
  initialise() {
    db = Database();
    db!.initiliase();
    db!.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Text(
            user.email!,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                }),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                }),
          ],
        ),
        body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  View(motogp: docs[index], db: db!)))
                      .then((value) => {
                            if (value != null) {initialise()}
                          });
                },
                contentPadding: EdgeInsets.only(right: 30, left: 36),
                title: Text(docs[index]['prezime']),
                subtitle: Text(docs[index]['ime']),
                trailing: Text(docs[index]['tim']),
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FilterScreen()));
              },
              tooltip: 'Filtriranje',
              child: Icon(Icons.filter_list_outlined),
              backgroundColor: buttonColor,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Add(db: db!)))
                    .then((value) {
                  if (value != null) {
                    initialise();
                  }
                });
              },
              tooltip: 'Dodavanje',
              child: Icon(Icons.add),
              backgroundColor: buttonColor,
            ),
          ],
        ));
  }
}
