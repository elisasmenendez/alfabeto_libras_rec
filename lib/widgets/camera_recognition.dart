import "package:alfabeto_libras_rec/controllers/scan_controller.dart";
import "package:flutter/material.dart";
import "package:get/get_rx/src/rx_types/rx_types.dart";

class CameraRecognition extends StatelessWidget {
  final ScanController controller;
  const CameraRecognition({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 150,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color(0xFF120320),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWidget(),
              const SizedBox(height: 20),
              RecognitionWidget(letters: controller.letters)
            ],
          ),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Letra do alfabeto",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}

class RecognitionWidget extends StatelessWidget {
  final RxMap<String, double>? letters;
  const RecognitionWidget({super.key, this.letters});

  @override
  Widget build(BuildContext context) {
    if (letters == null || letters!.isEmpty) {
      return const Text(
        "Não reconhecida",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
      );
    }

    return Text(
      letters.toString(),
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
    );
  }
}
