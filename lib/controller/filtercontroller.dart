import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:motogp/controller/chipcontroller.dart';

import '../model/motogp_model.dart';

class FilterController extends GetxController {
  final CollectionReference _motogpRef =
      FirebaseFirestore.instance.collection('motogp');

  var motogpList = <MotogpModel>[].obs;

  ChipController _chipController = Get.put(ChipController());

  @override
  void onInit() {
    motogpList
        .bindStream(getMotogp(MotogpTim.values[_chipController.selectedChip]));
    super.onInit();
  }

  Stream<List<MotogpModel>> getMotogp(MotogpTim tim) {
    switch (tim) {
      case MotogpTim.YAMAHA:
        Stream<QuerySnapshot> stream =
            _motogpRef.where('tim', isEqualTo: 'Yamaha').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return MotogpModel.fromDocumentSnapshot(snap);
            }).toList());

      case MotogpTim.HONDA:
        Stream<QuerySnapshot> stream =
            _motogpRef.where('tim', isEqualTo: 'Honda').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return MotogpModel.fromDocumentSnapshot(snap);
            }).toList());
      case MotogpTim.SUZUKI:
        Stream<QuerySnapshot> stream =
            _motogpRef.where('tim', isEqualTo: 'Suzuki').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return MotogpModel.fromDocumentSnapshot(snap);
            }).toList());
      case MotogpTim.APRILIA:
        Stream<QuerySnapshot> stream =
            _motogpRef.where('tim', isEqualTo: 'Aprilia').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return MotogpModel.fromDocumentSnapshot(snap);
            }).toList());
      case MotogpTim.DUCATI:
        Stream<QuerySnapshot> stream =
            _motogpRef.where('tim', isEqualTo: 'Ducati').snapshots();
        return stream.map((snapshot) => snapshot.docs.map((snap) {
              return MotogpModel.fromDocumentSnapshot(snap);
            }).toList());
    }
  }
}
