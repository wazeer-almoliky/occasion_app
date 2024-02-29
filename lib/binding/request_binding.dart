import 'package:get/get.dart';
import 'package:occasion_app/controller/request_controller.dart';

class RequestBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ResquestController(),fenix: true);
  }
  
}