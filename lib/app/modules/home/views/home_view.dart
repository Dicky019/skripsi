import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';
import '../widgets/linear_chart.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextAndValue(name: "UMUR", value: controller.umurC.text),
                  TextAndValue(name: "", value: controller.activitas)
                ],
              ),
            ),
            Center(
              child: LineChartCostum(
                spots: state!.toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextAndValue(
                name: "NILAI BPM NYA",
                value: "${state.valueBPM()}",
              ),
            ),
            const WrapperAnimationWidget()
          ],
        ),
        onEmpty: const EmptyData(),
      ),
    );
  }
}

class WrapperAnimationWidget extends GetView<HomeController> {
  const WrapperAnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isWarning.value
          ? AnimationWidget(
              value: "Danger", isWarning: controller.isWarning.value)
          : AnimationWidget(
              value: "Well", isWarning: controller.isWarning.value),
    );
  }
}

class AnimationWidget extends StatelessWidget {
  final String value;
  final bool isWarning;
  const AnimationWidget(
      {Key? key, required this.value, required this.isWarning})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 15,
        ),
        Center(
          child: LottieBuilder.asset(
            isWarning ? "assets/warning.json" : "assets/ok.json",
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            color: isWarning ? Colors.redAccent : const Color(0xff417505),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class TextAndValue extends StatelessWidget {
  final String name;
  final String value;
  const TextAndValue({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class EmptyData extends GetView<HomeController> {
  const EmptyData({Key? key}) : super(key: key);

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
                validator: (value) =>
                    value != null ? null : "Tidak Boleh Kosong",
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
                // onChanged: (value) => controller.activity = value ?? false,
                onChanged: (value) {
                  log(value.toString());
                }),
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
}

enum Aktivitas {
  setelahBerolahraga,
  tidakBerolahraga;
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
