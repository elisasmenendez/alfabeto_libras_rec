import 'package:alfabeto_libras_rec/helper/image_classification_helper.dart';
import 'package:camera/camera.dart';
import 'package:get/state_manager.dart';

class ScanController extends GetxController {
  final RxBool _isInitialized = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  int _imageCount = 0;
  late ImageClassificationHelper _imageClassificationHelper;
  RxMap<String, double>? _letters;

  bool get isInitialized => _isInitialized.value;
  CameraController get cameraController => _cameraController;
  RxMap<String, double>? get letters => _letters;

  @override
  void onInit() {
    _initCamera();
    _initModel();
    super.onInit();
  }

  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    _imageClassificationHelper.close();
    super.dispose();
  }

  Future<void> _initModel() async {
    _imageClassificationHelper = ImageClassificationHelper();
    _imageClassificationHelper.initHelper();
  }

  Future<void> _recognizeSign(CameraImage cameraImage) async {
    String datetime = DateTime.now().toString();
    print("Reconhecendo o sinal...$datetime");

    Map<String, double>? classification =
        await _imageClassificationHelper.inferenceCameraFrame(cameraImage);
    Map<String, double> filtered = Map.fromEntries(
        classification.entries.toList().where((entry) => entry.value >= 0.7));
    Map<String, double> sorted = Map.fromEntries(filtered.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    _letters = Map.fromEntries(sorted.entries.toList().reversed.take(1)).obs;
    update();

    print(_letters);
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      _isInitialized.value = true;
      _cameraController.startImageStream((image) {
        _imageCount++;
        if (_imageCount % 30 == 0) {
          _imageCount = 0;
          _recognizeSign(image);
        }
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }
}
