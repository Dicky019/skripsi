import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../controllers/home_controller.dart';
import '../../models/bpm_model.dart';

class InputData extends GetView<HomeController> {
  const InputData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "Data ...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.umurC,
              maxLength: 2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                return value != null && value.trim().isNotEmpty
                    ? null
                    : "Tidak Boleh Kosong";
              },
              decoration: inputDecorationCostum(
                titel: 'Umur',
                icon: LineIcons.calendarAlt,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            DropdownButtonFormField<Aktivitas>(
              validator: (value) => value != null ? null : "Tidak Boleh Kosong",
              decoration: inputDecorationCostum(
                titel: "Aktivitas",
                icon: LineIcons.walking,
              ),
              items: const [
                DropdownMenuItem<Aktivitas>(
                  value: Aktivitas.setelahBerolahraga,
                  child: Text('Setelah Berolahraga'),
                ),
                DropdownMenuItem<Aktivitas>(
                  value: Aktivitas.tidakBerolahraga,
                  child: Text('Tidak Berolahraga'),
                ),
              ],
              iconSize: 0,
              onChanged: (value) =>
                  controller.activity = value ?? Aktivitas.setelahBerolahraga,
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: Get.width,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.saveData,
                child: const Text("Simpan"),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecorationCostum(
      {required String titel, required IconData icon}) {
    return InputDecoration(
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[400]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      labelText: titel,
      isDense: true,
      suffixIcon: Icon(
        icon,
        size: 26,
      ),
    );
  }
}
