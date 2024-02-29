import 'package:get/get.dart';
import 'package:occasion_app/controller/reserve_controller.dart';

class ReserveBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ReserveController(),fenix: true);
  }
  
}