import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motogp/controller/searchcontroller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color buttonColor = Color(0xff25bcbb);

  final TextEditingController searchController = TextEditingController();
  QuerySnapshot? snapshotData;
  bool isExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(snapshotData!.docs[index]['prezime']),
              subtitle: Text(snapshotData!.docs[index]['ime']),
              trailing: Text(snapshotData!.docs[index]['tim']),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            isExcecuted = false;
          });
        },
        backgroundColor: buttonColor,
      ),
      backgroundColor: primaryColor,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  val.queryData(searchController.text).then((value) {
                    snapshotData = value;
                    setState(() {
                      isExcecuted = true;
                    });
                  });
                },
              );
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Pretrazi", hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
        backgroundColor: secondaryColor,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text(
                  "Pretrazite vozaca",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}
