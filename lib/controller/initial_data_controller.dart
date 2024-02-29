import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/functions/status_request.dart';
import 'package:occasion_app/utilities/services/app_services.dart';

class InitialDataControllrt extends GetxController {
  final remoteState = RemoteState();
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final initialDataKey = GlobalKey<FormState>();
  late String serviceID;
  int? userID;
  final storage = AppService.getStorage;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    checkFromUser();
  }

  void login() async {
    if (initialDataKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.givenService, {
        "op_type": "insert",
        "givser_name": name.text,
        "givser_address": address.text,
        "givser_phone": phone.text,
        "service_id":
            remoteState.getID(remoteState.serviceState, serviceID).toString(),
        "user_id": userID.toString(),
      },label: "عملية الاضافة");
    }
  }

  TextEditingController listOfController(int index) {
    final controller = [name, address, phone];
    return controller[index];
  }

  void checkFromUser() async {
    if (storage!.read("userID") != null) {
      userID = storage!.read("userID");
      log("${storage!.read("userID")}");
      update();
    }
  }

  List<String> listOfDataService() {
    return remoteState.getNames(remoteState.serviceState);
  }

  void fetchData() async {
    remoteState.isLoading(true);
    remoteState.serviceState.clear();
    try {
      final response =
          await remoteState.api.respone("${AppLinks.service}?op_type=select");
      if (response != null) {
        remoteState.serviceState
            .addAll(response.map((e) => Service.fromjson(e)).toList());
        remoteState.serviceState.refresh();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }
}
