import 'dart:developer';

import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/services/app_services.dart';

class DetailsViewController extends GetxController{
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  var user="";
  int? id;
  String? name;
  @override
  void onInit() {
    super.onInit();
    id=Get.arguments["id"];
    name=Get.arguments["name"];
    checkFromUser();
    fetchData();
    log(id.toString());
  }
  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      user = storage!.read("userType");
      update();
    }
  }
  void fetchData() async {
    remoteState.serviceState.clear();
    remoteState.servicesState.clear();
    remoteState.photoState.clear();
    //remoteState.isLoading(true);
    try {
      final response = await Future.wait([
        remoteState.api.respone("${AppLinks.product}?op_type=select&giver_id=$id"),
        remoteState.api.respone("${AppLinks.service}?op_type=select"),
        remoteState.api.respone("${AppLinks.photo}?op_type=select2"),
      ]);
      if (user == "ادمن") {
        if (response[1] != null) {
          remoteState.serviceState
              .addAll(response[1]!.map((e) => Service.fromjson(e)).toList());
          remoteState.serviceState.refresh();
        }
      } else {
        if (response[0] == null || response[2] == null){
          return;
        }
        if (response[0] != null || response[2] != null) {
          remoteState.servicesState.addAll(
              response[0]!.map((e) => Services.fromjson(e)).toList());
          remoteState.servicesState.refresh();
          log("${remoteState.servicesState[0].name}");
          remoteState.photoState.addAll(
              response[2]!.map((e) => Photo.fromjson(e)).toList());
          remoteState.photoState.refresh();
        }
      }
    } finally {
      //remoteState.isLoading(false);
    }
  } 
}