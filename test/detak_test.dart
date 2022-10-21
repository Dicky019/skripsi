import 'package:flutter_test/flutter_test.dart';
import 'package:skripsi/app/modules/home/models/bpm_model.dart';

void main() {
  group('Tidak Berolahraga', () {
    test('umur 1 - 3', () {
      tesTidakBerolahraga(
          umurAwal: 1, umurAkhir: 3, bpmAwal: 80, bpmAkhir: 130);
    });
    test('umur 4 - 5', () {
      tesTidakBerolahraga(
          umurAwal: 4, umurAkhir: 5, bpmAwal: 80, bpmAkhir: 120);
    });

    test('umur 6 - 10', () {
      tesTidakBerolahraga(
          umurAwal: 6, umurAkhir: 10, bpmAwal: 70, bpmAkhir: 110);
    });

    test('umur 11 - 14', () {
      tesTidakBerolahraga(
          umurAwal: 11, umurAkhir: 14, bpmAwal: 60, bpmAkhir: 105);
    });

    test('umur 15 - 60', () {
      tesTidakBerolahraga(
          umurAwal: 15, umurAkhir: 60, bpmAwal: 60, bpmAkhir: 100);
    });
  });

  group('Berolahraga', () {
    test('umur 20 - 29', () {
      tesBerolahraga(umurAwal: 20, umurAkhir: 29, bpmAwal: 100, bpmAkhir: 170);
    });
    test('umur 30 - 34', () {
      tesBerolahraga(umurAwal: 30, umurAkhir: 34, bpmAwal: 95, bpmAkhir: 162);
    });

    test('umur 35 - 39', () {
      tesBerolahraga(umurAwal: 35, umurAkhir: 39, bpmAwal: 93, bpmAkhir: 157);
    });

    test('umur 40 - 44', () {
      tesBerolahraga(umurAwal: 40, umurAkhir: 44, bpmAwal: 90, bpmAkhir: 153);
    });
    test('umur 45 - 49', () {
      tesBerolahraga(umurAwal: 45, umurAkhir: 49, bpmAwal: 88, bpmAkhir: 149);
    });
    test('umur 50 - 59', () {
      tesBerolahraga(umurAwal: 50, umurAkhir: 59, bpmAwal: 85, bpmAkhir: 145);
    });

    test('umur 60 - 100', () {
      tesBerolahraga(umurAwal: 60, umurAkhir: 100, bpmAwal: 80, bpmAkhir: 136);
    });

    // test('umur 15 - 19', () {
    //   tesBerolahraga(umurAwal: 15, umurAkhir: 19, bpmAwal: 60, bpmAkhir: 100);
    // });
  });
}

void tesTidakBerolahraga(
    {required int umurAwal,
    required int umurAkhir,
    required int bpmAwal,
    required int bpmAkhir}) {
  var berhasil = false;
  ModelBpm modelBpm = ModelBpm.emptyData();
  for (var j = umurAwal; j <= umurAkhir; j++) {
    for (var i = bpmAwal; i <= bpmAkhir; i++) {
      var bpm = i;
      print("Umur $j - bpm $bpm");
      expect(
        modelBpm.tidakBerolahraga(j, bpm),
        berhasil,
      );
    }
  }
}

void tesBerolahraga({
  required int umurAwal,
  required int umurAkhir,
  required int bpmAwal,
  required int bpmAkhir,
}) {
  var berhasil = false;
  ModelBpm modelBpm = ModelBpm.emptyData();
  for (var j = umurAwal; j <= umurAkhir; j++) {
    for (var i = bpmAwal; i <= bpmAkhir; i++) {
      var bpm = i;
      print("Umur $j - bpm $bpm");
      expect(
        modelBpm.berolahraga(j, bpm),
        berhasil,
      );
    }
  }
}
