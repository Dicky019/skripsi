import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class AnimationWidget extends GetView<HomeController> {
  const AnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isWarning.value
          ? animationWidget(
              value: "Danger",
              isWarning: controller.isWarning.value,
            )
          : animationWidget(
              value: "Well",
              isWarning: controller.isWarning.value,
            ),
    );
  }

  Widget animationWidget({
    required String value,
    required bool isWarning,
  }) {
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
