import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertUtil {
  static void alertCostum(bool isNotWell) {
    Get.snackbar(isNotWell ? "Tidak Sehat" : "Sehat", "",
        messageText: Text(
          isNotWell ? tidakSehat : sehat,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 5));
  }

  static const sehat = """Terima Kasih Telah Melakukan Pemeriksaan.

Hasil : Jantung Normal

Tetaplah menjaga pola hidup sehat. 
Sayangi jantung kita dengan menerapkan perilaku CERDIK:
1. Cek kesehatan berkala 
2. Hindari rokok, minuman keras dan sejenisnya 
3. Istirahat cukup 
TERIMA KASIH 🙏""";

  static const tidakSehat = """Terima Kasih Telah Melakukan Pemeriksaan.

Hasil : Jantung Tidak Normal

Harap melakukan pemeriksaan lebih lanjut di rumah sakit terdekat.
Sayangi jantung kita dengan : 
1. Konsumsi makanan yang sehat untuk jantung, seperti ikan kacang, buah beri, sayuran hijau dll.
2. Berhenti Merokok dan minuman beralkohol.
3.Olahraga teratur.
4.Cek kesehatan rutin.
TERIMA KASIH 🙏""";
}
