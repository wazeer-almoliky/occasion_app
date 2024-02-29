import 'package:get/get.dart';
import 'package:occasion_app/controller/login_controller.dart';
class LoginBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => LoginController(),fenix: true);
  }
}