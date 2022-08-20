import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/app/modules/home/models/detak_jantung_model.dart';

class HomeController extends GetxController with StateMixin<String> {
  final firebaseRealtime = FirebaseDatabase.instance.ref();
  final firebaseCloud = FirebaseFirestore.instance;
  final umurC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var activity = false;
  String data = "";
  late SharedPreferences prefs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    umurC.text = prefs.getString("umur") ?? "";
    activity = prefs.getBool("activity") ?? false;
    if (umurC.text != "" && activity != false) {
      getDataToFirestore();
    } else {
      change(null, status: RxStatus.empty());
    }
    super.onInit();
  }

  void getDataToFirestore() {
    firebaseRealtime.child("Status BPM").child("BPM").onValue.listen((event) {
      data = event.snapshot.value.toString();
      addData(
        DetakJantungModel(
          jumlah: data,
          waktu: Timestamp.now(),
        ),
      );
      change(data, status: RxStatus.success());
    });
  }

  void addData(DetakJantungModel detakJantungModel) async {
    await firebaseCloud
        .collection("Data Detak Jantung")
        .withConverter<DetakJantungModel>(
          fromFirestore: (snapshot, options) =>
              DetakJantungModel.fromSnapshot(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .add(detakJantungModel);
  }

  saveData() async {
    if (formKey.currentState?.validate() ?? false) {
      change(null, status: RxStatus.loading());
      await prefs.setString("umur", umurC.text);
      await prefs.setBool("activity", activity);
      getDataToFirestore();
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
