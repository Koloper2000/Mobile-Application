import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore? firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String ime, String prezime, String tim, int godine,
      int pobede, int podiumi, int polpozicije) async {
    try {
      await firestore!.collection("motogp").add({
        'ime': ime,
        'prezime': prezime,
        'tim': tim,
        'godine': godine,
        'pobede': pobede,
        'podiumi': podiumi,
        'polpozicije': polpozicije,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore!.collection("motogp").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore!.collection('motogp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "ime": doc['ime'],
            "prezime": doc["prezime"],
            "tim": doc["tim"],
            "godine": doc["godine"],
            "pobede": doc["pobede"],
            "podiumi": doc["podiumi"],
            "polpozicije": doc["polpozicije"],
          };
          docs.add(a);
        }
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<void> update(String id, String ime, String prezime, String tim,
      int godine, int pobede, int podiumi, int polpozicije) async {
    try {
      await firestore!.collection("motogp").doc(id).update({
        'ime': ime,
        'prezime': prezime,
        'tim': tim,
        'godine': godine,
        'pobede': pobede,
        'podiumi': podiumi,
        'polpozicije': polpozicije,
      });
    } catch (e) {
      print(e);
    }
  }
}
