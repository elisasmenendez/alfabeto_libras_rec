import "package:alfabeto_libras_rec/controllers/scan_controller.dart";
import "package:alfabeto_libras_rec/widgets/camera_recognition.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CameraViewer extends StatelessWidget {
  const CameraViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanController>(builder: (controller) {
      if (!controller.isInitialized) {
        return Container();
      }
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
                width: Get.width,
                height: Get.height,
                child: CameraPreview(controller.cameraController)),
            CameraRecognition(controller: controller),
          ],
        ),
      );
    });
  }
}
