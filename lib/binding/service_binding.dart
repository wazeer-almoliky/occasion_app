import 'package:get/get.dart';
import 'package:occasion_app/controller/services_controller.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ServicesController(),fenix: false);
  }
  
}