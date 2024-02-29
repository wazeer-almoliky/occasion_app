import 'package:get/get.dart';
import 'package:occasion_app/controller/home_controller.dart';
class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),fenix: true);
  }
  
}