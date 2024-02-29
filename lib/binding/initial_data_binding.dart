import 'package:get/get.dart';
import 'package:occasion_app/controller/initial_data_controller.dart';

class InitialData extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialDataControllrt(),fenix: false);
  }
  
}