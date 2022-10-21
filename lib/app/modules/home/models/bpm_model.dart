import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

enum Aktivitas {
  setelahBerolahraga(true),
  tidakBerolahraga(false);

  const Aktivitas(this.value);
  final bool value;
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

  factory ModelBpm.emptyData() => ModelBpm(
        detikKe0: 0,
        detikKe1: 0,
        detikKe2: 0,
        detikKe3: 0,
        detikKe4: 0,
        detikKe5: 0,
      );

  List<int?> get _list =>
      [detikKe0, detikKe1, detikKe2, detikKe3, detikKe4, detikKe5];

  List<FlSpot> toList() {
    return List.generate(_list.length,
        (index) => FlSpot(index.toDouble(), _list[index]!.toDouble()));
  }

  int valueBPM() {
    var valueBPM = 0;
    for (var data in _list) {
      valueBPM += data ?? 0;
    }
    return valueBPM * 2;
  }

  bool checkBPM(int umur,Aktivitas aktivitas,bpm) {
    return aktivitas.value ? berolahraga(umur,bpm) : tidakBerolahraga(umur,bpm);
  }

   bool tidakBerolahraga(int umur,int bpm){

    if (umur >= 15 && umur <= 60) {
      if (bpm <= 59) {
        log("Kurang dari 60");
        Get.snackbar("Umur $umur", "Kurang dari 60");
        return true;
      }
      if (bpm >= 101) {
        log("Lebih dari 100");
        Get.snackbar("Umur $umur", "Lebih dari 100");
        return true;
      }
    }

    if (umur >= 11 && umur <= 14) {
      if (bpm <= 59) {
        log("Kurang dari 60");
        Get.snackbar("Umur $umur", "Kurang dari 60");
        return true;
      }
      if (bpm >= 106) {
        log("Lebih dari 105");
        Get.snackbar("Umur $umur", "Lebih dari 105");
        return true;
      }
    }

    if (umur >= 6 && umur <= 10) {
      if (bpm <= 69) {
        log("Kurang dari 70");
        Get.snackbar("Umur $umur", "Kurang dari 70");
        return true;
      }
      if (bpm >= 111) {
        log("Lebih dari 110");
        Get.snackbar("Umur $umur", "Lebih dari 110");
        return true;
      }
    }

    if (umur >= 4 && umur <= 5) {
      if (bpm <= 79) {
        log("Kurang dari 80");
        Get.snackbar("Umur $umur", "Kurang dari 80");
        return true;
      }
      if (bpm >= 121) {
        log("Lebih dari 120");
        Get.snackbar("Umur $umur", "Lebih dari 120");
        return true;
      }
    }
    if (umur >= 1 && umur <= 3) {
      if (bpm <= 79) {
        log("Kurang dari 80");
        Get.snackbar("Umur $umur", "Kurang dari 80");
        return true;
      }
      if (bpm >= 131) {
        log("Lebih dari 130");
        Get.snackbar("Umur $umur", "Lebih dari 130");
        return true;
      }
    }
    return false;
  }

   bool berolahraga(int umur,int bpm){
    
    log(umur.toString());
    // TODO : 60
    if (umur >= 60) {
      if (bpm <= 79) {
        log("Kurang dari 80");
        Get.snackbar("Umur $umur", "Kurang dari 80");
        return true;
      }
      if (bpm >= 137) {
        log("Lebih dari 136");
        Get.snackbar("Umur $umur", "Lebih dari 136");
        return true;
      }
    }
    // TODO : 50
    else if (umur >= 50) {
      if (bpm <= 84) {
        log("Kurang dari 85");
        Get.snackbar("Umur $umur", "Kurang dari 85");
        return true;
      }
      if (bpm >= 146) {
        log("Lebih dari 145");
        Get.snackbar("Umur $umur", "Lebih dari 145");
        return true;
      }
    }
    // TODO : 45
    else if (umur >= 45) {
      if (bpm <= 87) {
        log("Kurang dari 88");
        Get.snackbar("Umur $umur", "Kurang dari 88");
        return true;
      }
      if (bpm >= 150) {
        log("Lebih dari 149");
        Get.snackbar("Umur $umur", "Lebih dari 149");
        return true;
      }
    }
    // TODO : 40
    else if (umur >= 40) {
      if (bpm <= 89) {
        log("Kurang dari 90");
        Get.snackbar("Umur $umur", "Kurang dari 90");
        return true;
      }
      if (bpm >= 154) {
        log("Lebih dari 153");
        Get.snackbar("Umur $umur", "Lebih dari 153");
        return true;
      }
    }
    // TODO : 35
    else if (umur >= 35) {
      if (bpm <= 92) {
        log("Kurang dari 93");
        Get.snackbar("Umur $umur", "Kurang dari 93");
        return true;
      }
      if (bpm >= 158) {
        log("Lebih dari 157");
        Get.snackbar("Umur $umur", "Lebih dari 157");
        return true;
      }
    }
    // TODO : 30
    else if (umur >= 30) {
      if (bpm <= 94) {
        log("Kurang dari 95");
        Get.snackbar("Umur $umur", "Kurang dari 95");
        return true;
      }
      if (bpm >= 163) {
        log("Lebih dari 162");
        Get.snackbar("Umur $umur", "Lebih dari 162");
        return true;
      }
    }
    // TODO : 20
    else if (umur >= 20) {
      if (bpm <= 99) {
        log("Kurang dari 100");
        Get.snackbar("Umur $umur", "Kurang dari 100");
        return true;
      }
      if (bpm >= 171) {
        log("Lebih dari 170");
        Get.snackbar("Umur $umur", "Lebih dari 170");
        return true;
      }
    }
    return false;
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