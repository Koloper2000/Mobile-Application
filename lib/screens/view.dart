// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/database.dart';

class View extends StatefulWidget {
  View({Key? key, required this.motogp, required this.db}) : super(key: key);
  Map motogp;
  Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color buttonColor = Color(0xff25bcbb);

  TextEditingController imeController = new TextEditingController();
  TextEditingController prezimeController = new TextEditingController();
  TextEditingController timController = new TextEditingController();
  TextEditingController godineController = new TextEditingController();
  TextEditingController pobedeController = new TextEditingController();
  TextEditingController podiumiController = new TextEditingController();
  TextEditingController polpozicijeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.motogp);
    imeController.text = widget.motogp['ime'];
    prezimeController.text = widget.motogp['prezime'];
    timController.text = widget.motogp['tim'];
    godineController.text = widget.motogp['godine'].toString();
    pobedeController.text = widget.motogp['pobede'].toString();
    podiumiController.text = widget.motogp['podiumi'].toString();
    polpozicijeController.text = widget.motogp['polpozicije'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text("Pregled vozaca"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(widget.motogp["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Ime"),
                controller: imeController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Prezime"),
                controller: prezimeController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Tim"),
                controller: timController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Godine"),
                controller: godineController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Pobede"),
                controller: pobedeController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Podiumi"),
                controller: podiumiController,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Pol Pozicije"),
                controller: polpozicijeController,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: buttonColor,
              onPressed: () {
                widget.db.update(
                  widget.motogp['id'],
                  imeController.text.trim(),
                  prezimeController.text.trim(),
                  timController.text.trim(),
                  int.parse(godineController.text.trim()),
                  int.parse(pobedeController.text.trim()),
                  int.parse(podiumiController.text.trim()),
                  int.parse(polpozicijeController.text.trim()),
                );
                Navigator.pop(context, true);
              },
              child: Text(
                "Sacuvaj",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: buttonColor,
          width: 2.0,
        ),
      ),
    );
  }
}
