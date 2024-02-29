import 'package:get/get.dart';
import 'package:occasion_app/controller/dashboard_controller.dart';
class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(),fenix: true);
  }
  
}