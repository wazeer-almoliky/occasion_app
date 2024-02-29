import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/dashboard_binding.dart';
import 'package:occasion_app/model/remote/api_data.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/classes/custom_dialog.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/api_function.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/dashboard.dart';

class LoginController extends GetxController {
  final remoteState = RemoteState();
  final user = TextEditingController();
  final pass = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  final api = ApiData(Get.find<Crud>());
  final storageService = Get.find<AppService>();
  final storage = AppService.getStorage;
  bool isEnablePassword=true;
  void login() async {
    if (loginKey.currentState!.validate()) {
      StatusRequest.loading;
      final data = await remoteState.api.respone(
          "${AppLinks.user}?op_type=login&user_name=${user.text}&user_password=${pass.text}",isSignUp: true);
      if (data != null) {
        if (data.isEmpty) {
          CustomAlertDialog.showSnackBar(
              "تـأكد من اســم المستخــدم أو كلمـة المرور",
              size: 18,
              color: AppColors.red);
          return;
        }
        if (data[0]["user_state"] == 0) {
          CustomAlertDialog.showSnackBar(
              "اســم المستخـدم لم يتـم تفعليه بعـد!.",
              size: 18,
              color: AppColors.red);
          return;
        }
        storage!.write("userType", data[0]["user_type"]);
        storage!.write("userName", data[0]["user_name"]);
        storage!.write("userID", data[0]["user_id"]);
        Future.delayed(const Duration(seconds: 2), () async {
          await navigateToLoginScreen();
        });
        log("ID... ${data[0]["user_id"]}");
      }
    }
  }
  void enablePassword(){
    isEnablePassword=!isEnablePassword;
    update();
  }
  Future<void> navigateToLoginScreen() async {
    await Get.off(() => const Dashboard(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.leftToRightWithFade,
        binding: DashboardBinding());
  }

  TextEditingController listOfController(int index) {
    final controller = [user, pass];
    return controller[index];
  }

  void checkApi() async {
    const url = AppLinks.user;
    final data = await remoteState.api.respone("$url?op_type=login&user_name=abrar&user_password=12345");
    if (data != null) {
      log("DATA >>>$data");
    }
  }
}
