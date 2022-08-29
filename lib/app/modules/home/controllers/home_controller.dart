import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/app/modules/home/models/detak_jantung_model.dart';

class HomeController extends GetxController
    with StateMixin<ModelBpm> {
  final firebaseRealtime = FirebaseDatabase.instance.ref("/Status Beat");
  final umurC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var activity = false;
  String data = "";
  late SharedPreferences prefs;

  get activitas => activity ? "BERAKTIVITAS" : "TIDAK BERAKTIVITAS";

  final collectionReferenceDetakJantung = FirebaseFirestore.instance
      .collection("Data Detak Jantung")
      .withConverter<DetakJantungModel>(
        fromFirestore: (snapshot, options) =>
            DetakJantungModel.fromSnapshot(snapshot),
        toFirestore: (value, options) => value.toJson(),
      );

  @override
  void onInit() async {
    initData();
    // getBpm();
    super.onInit();
  }

  // TODO : BPM
  void getBpm() {
    firebaseRealtime.onValue.listen(
      (event) {
        final json = event.snapshot.value as Map;
        final data = ModelBpm.fromJson(json);
        log(data.toJson().toString());
        change(data,status: RxStatus.success());
      },
    );
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
    umurC.text = prefs.getString("umur") ?? "";
    activity = prefs.getBool("activity") ?? false;
    if (umurC.text != "" && activity != false) {
      getBpm();
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  saveData() async {
    if (formKey.currentState?.validate() ?? false) {
      change(null, status: RxStatus.loading());
      await prefs.setString("umur", umurC.text);
      await prefs.setBool("activity", activity);
      getBpm();
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

class ModelBpm {
  ModelBpm({
    this.detikKe1,
    this.detikKe2,
    this.detikKe0,
    this.detikKe5,
    this.detikKe3,
    this.detikKe4,
  });

  final int? detikKe1;
  final int? detikKe2;
  final int? detikKe0;
  final int? detikKe5;
  final int? detikKe3;
  final int? detikKe4;

  factory ModelBpm.fromJson(Map<dynamic, dynamic> json) => ModelBpm(
        detikKe0: json["detik ke 0"],
        detikKe1: json["detik ke 1"],
        detikKe2: json["detik ke 2"],
        detikKe3: json["detik ke 3"],
        detikKe4: json["detik ke 4"],
        detikKe5: json["detik ke 5"],
      );

      List<FlSpot> toList ()  {
        final listData = [detikKe0,detikKe1,detikKe2,detikKe3,detikKe4,detikKe5];
        return List.generate(listData.length, (index) => FlSpot(index.toDouble(),listData[index]!.toDouble()));
      }

  Map<String, dynamic> toJson() => {
        "detik ke 0": detikKe0,
        "detik ke 1": detikKe1,
        "detik ke 2": detikKe2,
        "detik ke 3": detikKe3,
        "detik ke 4": detikKe4,
        "detik ke 5": detikKe5,
      };
}
