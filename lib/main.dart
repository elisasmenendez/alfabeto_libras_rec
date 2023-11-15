import 'package:alfabeto_libras_rec/global_bindings.dart';
import 'package:alfabeto_libras_rec/widgets/camera_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alfabeto Libras',
      home: const CameraViewer(),
      initialBinding: GlobalBindings(),
    );
  }
}
