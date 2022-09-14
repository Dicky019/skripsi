import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 //  TODO : to local data
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/app/modules/home/models/detak_jantung_model.dart';

import '../models/bpm_model.dart';
import '../views/home_view.dart';

class HomeController extends GetxController with StateMixin<ModelBpm> {
  final firebaseRealtime = FirebaseDatabase.instance.ref("/Status Beat");
  final umurC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final activity = Aktivitas.setelahBerolahraga;
  final isWarning = false.obs;
  String data = "";
   //  TODO : to local data
  // late SharedPreferences prefs;

  String get activitas => Aktivitas.setelahBerolahraga == activity ? "Setelah Berolahraga" : "Tidak Berolahraga";

  final collectionReferenceDetakJantung = FirebaseFirestore.instance
      .collection("BPM")
      .withConverter<ModelBPMFirebase>(
        fromFirestore: (snapshot, options) =>
            ModelBPMFirebase.fromSnapshot(snapshot),
        toFirestore: (value, options) => value.toJson(),
      );

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
        int umur = int.parse(umurC.text) ;
        isWarning.value = data.checkBPM(umur);
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
      //  TODO : to local data
      // await prefs.setString("umur", umurC.text);
      // await prefs.setBool("activity", activity);
      getBpm();
    }
  }
}
	// 1.20 thn : normal 100 – 170 bpm, maksimal 200 bpm
	// 2.30 thn : normal 95 – 162 bpm, maksimal 190 bpm
	// 3.35 thn : normal 93 – 157 bpm, maksimal 185 bpm
	// 4.40 thn : normal 90 – 153 bpm, maksimal 170 bpm
	// 5.45 thn : normal 88 – 149 bpm , maksimal 175 bpm
	// 6.50 thn : normal 85 – 145 bpm , maksimal 170 bpm
	// 7.60 thn : normal 80 – 136 bpm , maksimal 160 bpm.
	// Lansia diatas 60 thn Ketika olahraga = 80 – 130 per menit



