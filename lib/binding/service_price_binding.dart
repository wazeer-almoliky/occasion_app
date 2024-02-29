import 'package:get/get.dart';
import 'package:occasion_app/controller/service_price_controller.dart';

class ServicePriceBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ServicePriceController());
  }
  
}