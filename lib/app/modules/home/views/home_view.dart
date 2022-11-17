import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/animation_widget.dart';
import '../widgets/linear_chart.dart';
import '../widgets/state/input.dart';
import '../widgets/text_and_value.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.appBar.value)),
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
                  TextAndValue(
                    name: "UMUR",
                    value: controller.umurC.text,
                  ),
                  Text(
                    controller.activitas,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
            const AnimationWidget(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: Get.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.deleteData,
                  child: const Text("Input Ulang"),
                ),
              ),
            )
          ],
        ),
        onEmpty: const InputData(),
      ),
    );
  }
}

