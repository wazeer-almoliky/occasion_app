import 'dart:developer';

import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/utilities/services/app_services.dart';

class ResquestController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  int? userState, userID;
  var admin = "";
  @override
  void onInit() {
    super.onInit();
    checkFromUser();
    fetchData();
    userState = Get.arguments["userState"];
  }

  void fetchData() async {
    remoteState.userState.clear();
    remoteState.reserveState.clear();
    remoteState.isLoading(true);
    try {
      final resp1 =
          await remoteState.api.respone("${AppLinks.user}?op_type=select");
      if (resp1 != null) {
        remoteState.userState
            .addAll(resp1.map((e) => User.fromjson(e)).toList());
        remoteState.userState.refresh();
      }
      final resp = userState == 0
          ? await remoteState.api.respone(
              "${AppLinks.reserve}?op_type=selectdisable&user_id=$userID")
          : await remoteState.api.respone(
              "${AppLinks.reserve}?op_type=selectEnable&user_id=$userID");
      if (resp != null) {
        remoteState.reserveState
            .addAll(resp.map((e) => Reserve.fromjson(e)).toList());
        remoteState.reserveState.refresh();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void updateData(int reserveID) async {
    StatusRequest.loading;
    await remoteState.api.request(AppLinks.reserve, {
      "op_type": "update",
      "reserve_status": 1.toString(),
      "reserve_id": reserveID.toString(),
    },label: "عملية التأكيد");
    log("$reserveID");
    // update();
    fetchData();
    update();
  }

  void updateUser(int userID, {int? disableUser,String? hint}) async {
    StatusRequest.loading;
    remoteState.api.request(AppLinks.user, {
      "op_type": "update2",
      "user_state": disableUser.toString(),
      "user_id": userID.toString(),
    },label:"عملية $hint " );
    fetchData();
    update();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }
}
