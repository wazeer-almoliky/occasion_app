import 'dart:developer';

import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/user_binding.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/view/screens/user_screen.dart';

class UpdateUserController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final user = TextEditingController();
  final pass = TextEditingController();
  final userKey = GlobalKey<FormState>();
  var admin = "";
  String? label;
  int? userID, userID2;
  @override
  void onInit() {
    checkFromUser();
    super.onInit();
    label = Get.arguments["label"];
    userID2 = Get.arguments["userID"];
    user.text = Get.arguments["name"];
  }

  TextEditingController listOfController(int index) {
    final controller = [user, pass];
    return controller[index];
  }

  void updateUser() async {
  log("$userID2");
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "update",
        "user_name": user.text,
        "user_type": "ادمن",
        "user_password": pass.text,
        "user_state": "1",
        "user_id": "$userID2",
      },
      label: "عملية التعديل"
      );
      Get.off(
      () => const UserScreen(),
      duration: const Duration(milliseconds: 400),
      transition: Transition.fadeIn,
      curve: Curves.ease,
      binding: UserBinding()
    );
    log("$userID2");
    }
    user.text = "";
    pass.text = "";
  }

  void addUser() async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "insert",
        "user_name": user.text,
        "user_type": "ادمن",
        "user_password": pass.text,
        "user_phone": "",
        "user_state": "1",
      },
      label: "عملية الاضافة"
      );
    }
    user.text = "";
    pass.text = "";
    Get.off(
      () => const UserScreen(),
      duration: const Duration(milliseconds: 400),
      transition: Transition.fadeIn,
      curve: Curves.ease,
      binding: UserBinding()
    );
  }

  void deleteUser(int id101) async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "delete",
        "user_id": "$id101",
      },
      label: "عملية الحذف"
      );
      Get.off(
      () => const UserScreen(),
      duration: const Duration(milliseconds: 400),
      transition: Transition.fadeIn,
      curve: Curves.ease,
      binding: UserBinding()
    );
    }
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }
}
