// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:skripsi/app/modules/home/models/bpm_model.dart';

// class ModelBPMFirebase {
//   ModelBPMFirebase({
//     this.id,
//     required this.bpm,
//     required this.waktu,
//     required this.aktivitas,
//     required this.umur,
//   });

//   final String? id;
//   final ModelBpm bpm;
//   final Timestamp waktu;
//   final String aktivitas;
//   final String umur;

//   factory ModelBPMFirebase.fromSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     var json = snapshot.data()!;
//     return ModelBPMFirebase(
//       id: snapshot.id,
//       bpm: json["bpm"],
//       waktu: json["waktu"],
//       aktivitas: json["aktivitas"],
//       umur: json["umur"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "bpm": bpm,
//         "Waktu": Timestamp.now(),
//         "aktivitas": aktivitas,
//         "umur": umur,
//       };
// }
