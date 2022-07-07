import 'package:cloud_firestore/cloud_firestore.dart';

class MotogpModel {
  String? ime;
  String? prezime;
  String? tim;
  int? godine;
  int? pobede;
  int? podiumi;
  int? polpozicije;

  MotogpModel(
    this.ime,
    this.prezime,
    this.godine,
    this.pobede,
    this.podiumi,
    this.polpozicije,
  );

  MotogpModel.fromDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    ime = snapshot.get('ime');
    prezime = snapshot.get('prezime');
    tim = snapshot.get('tim');
    godine = snapshot.get('godine');
    pobede = snapshot.get('pobede');
    podiumi = snapshot.get('podiumi');
    polpozicije = snapshot.get('polpozicije');
  }
}

enum MotogpTim { HONDA, SUZUKI, YAMAHA, APRILIA, DUCATI }
