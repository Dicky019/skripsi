import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//  TODO : to local data
// import 'package:shared_preferences/shared_preferences.dart';

import '../models/bpm_model.dart';

class HomeController extends GetxController with StateMixin<ModelBpm> {
  final firebaseRealtime = FirebaseDatabase.instance.ref("/Status Beat");
  final umurC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var activity = Aktivitas.setelahBerolahraga;
  final isWarning = false.obs;
  final appBar = "Input".obs;
  //  TODO : to local data
  // late SharedPreferences prefs;

  String get activitas => Aktivitas.setelahBerolahraga == activity
      ? "Setelah Berolahraga"
      : "Tidak Berolahraga";

  // final collectionReferenceDetakJantung = FirebaseFirestore.instance
  //     .collection("BPM")
  //     .withConverter<ModelBPMFirebase>(
  //       fromFirestore: (snapshot, options) =>
  //           ModelBPMFirebase.fromSnapshot(snapshot),
  //       toFirestore: (value, options) => value.toJson(),
  //     );

  @override
  void onInit() async {
    change(null, status: RxStatus.empty());
    // initData();
    // getBpm();
    super.onInit();
  }

  // TODO : BPM
  void getBpm() {
    firebaseRealtime.onValue.listen(
      (event) {
        final json = event.snapshot.value as Map;
        final data = ModelBpm.fromJson(json);
        change(data, status: RxStatus.success());
        int umur = int.parse(umurC.text);
        isWarning.value = data.checkBPM(umur, activity,data.valueBPM());
        appBar.value = "Cek Detak Jantung";
        log(isWarning.value.toString());
      },
    );
  }

  //  TODO : to local data
  // void initData() async {
  //   prefs = await SharedPreferences.getInstance();
  //   umurC.text = prefs.getString("umur") ?? "";
  //   activity = prefs.getBool("activity") ?? false;
  //   if (umurC.text != "" && activity != false) {
  //     getBpm();
  //   } else {
  //     change(null, status: RxStatus.empty());
  //   }
  // }

  Future<void> saveData() async {
    if (formKey.currentState?.validate() ?? false) {
      change(null, status: RxStatus.loading());
      getBpm();
    }
  }

  Future<void> deleteData() async {
    await firebaseRealtime.update(ModelBpm.emptyData().toJson());
    umurC.clear();
    appBar.value = "Input";
    change(null, status: RxStatus.empty());
  }
}
