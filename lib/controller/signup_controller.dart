import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/login_binding.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/view/screens/login_screen.dart';

class SignUpController extends GetxController {
  final remoteState = RemoteState();
  final user = TextEditingController();
  final pass = TextEditingController();
  final phone = TextEditingController();
  final signUpKey = GlobalKey<FormState>();
  bool isEnablePassword=true;
  void signUp() async {
    if (signUpKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "insert",
        "user_name": user.text,
        "user_password": pass.text,
        "user_state": "0",
        "user_phone": phone.text,
        "user_type": "عادي",
      },
      label: "الأضافة"
      );
      Future.delayed(const Duration(seconds: 3),()async{
        await navigateToLoginScreen();
      });
    }
  }

  Future<void> navigateToLoginScreen() async {
    await Get.off(() => const LoginScreen(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.downToUp,
        binding: LoginBinding());
  }

  TextEditingController listOfController(int index){
    final controller = [user,pass,phone];
    return controller[index];
  }
  void enablePassword(){
    isEnablePassword=!isEnablePassword;
    update();
  }
}
