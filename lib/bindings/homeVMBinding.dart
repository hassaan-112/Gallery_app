import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import '../view_model/localImage.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocalImagesViewModel(), permanent: true);
  }
}
