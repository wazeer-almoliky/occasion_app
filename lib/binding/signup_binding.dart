import 'package:get/get.dart';
import 'package:occasion_app/controller/signup_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() =>  SignUpController(),fenix: true);
  }
  
}