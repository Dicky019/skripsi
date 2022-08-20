import 'package:cloud_firestore/cloud_firestore.dart';

class DetakJantungModel {
  DetakJantungModel({
    this.id,
    required this.jumlah,
    required this.waktu,
  });
  String? id;
  String jumlah;
  Timestamp waktu;

  factory DetakJantungModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
   var json = snapshot.data()!;
   return DetakJantungModel(
        id: snapshot.id,
        jumlah: json["Jumlah"],
        waktu: json["Waktu"],
      );
  }
      

  Map<String, dynamic> toJson() => {
        "Jumlah": jumlah,
        "Waktu": waktu,
      };
}
