import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/services/app_services.dart';

class ReserveController extends GetxController {
  final storage = AppService.getStorage;
  //int? id;
  String? customerName, customerPhone;
  //int? id;
  final remoteState = RemoteState();
  final reserveKey = GlobalKey<FormState>();
  final date = TextEditingController(),
      purpose = TextEditingController(),
      count = TextEditingController();
  final listOfPayment = ["كــاش", "حســاب"];
  final listOfDropBoxValue = ["", ""];
  @override
  void onInit() {
    checkFromUser();
    //id = Get.arguments["id"];
    //name1 = Get.arguments["name"];
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      final response = await Future.wait([
        remoteState.api.respone("${AppLinks.period}?op_type=select"),
        remoteState.api.respone("${AppLinks.priceOfService}?op_type=select2"),
      ]);
      if (response[0] != null) {
        remoteState.periodState
            .addAll(response[0]!.map((e) => Period.fromjson(e)).toList());
        remoteState.periodState.refresh();
      }
      final resp = await remoteState.api
          .respone("${AppLinks.priceOfService}?op_type=select2");
      if (resp != null) {
        remoteState.priceState
            .addAll(resp.map((e) => Price.fromjson(e)).toList());
        remoteState.priceState.refresh();
      }
    } finally {
      //remoteState.isLoading(false);
    }
  }

  void request(int id,int priceS) async {
    checkFromUser();
    if (reserveKey.currentState!.validate()) {
      final data={
        "op_type": "insert",
        "reserve_day": DateTime.now().toString().substring(0, 10),
        "reserve_date": date.text,
        "reserve_purpose": purpose.text,
        "reserve_status": "0",
        "payment_method": listOfDropBoxValue[1],
        "reserve_price": "${priceS*int.parse(count.text)}",
        "reserve_quantity": count.text,
        "coustomer_name": customerName,
        "coustomer_phone": customerPhone,
        "product_id": "$id",
        "timeperiod_id": remoteState
            .getID(remoteState.periodState, listOfDropBoxValue[0])
            .toString(),
      };
      await remoteState.api.request(AppLinks.reserve, {
        "op_type": "insert",
        "reserve_day": DateTime.now().toString().substring(0, 10),
        "reserve_date": date.text,
        "reserve_purpose": purpose.text,
        "reserve_status": "0",
        "payment_method": listOfDropBoxValue[1],
        "reserve_price": "${priceS*int.parse(count.text)}",
        "reserve_quantity": count.text,
        "coustomer_name": customerName,
        "coustomer_phone": customerPhone,
        "product_id": "$id",
        "timeperiod_id": remoteState
            .getID(remoteState.periodState, listOfDropBoxValue[0])
            .toString(),
      },label: "عملية الحجز");

      log("$data");
    }
  }

  void checkFromUser() async {
    if (storage!.read("customerName") != null) {
      customerName = storage!.read("customerName");
      customerPhone = storage!.read("customerPhone");
      update();
    }
  }

  TextEditingController listOfController(int index) {
    final controller = [purpose, count, date];
    return controller[index];
  }

  List<String> listOfString(int index) {
    final list = [remoteState.getNames(remoteState.periodState), listOfPayment];
    return list[index];
  }

  int value = 0;
  void price(int val, {bool? isFromDrop = false}) {
    if (isFromDrop == true) {
      value = 2;
      update();
    } else {
      value = val;
      update();
    }
  }

  List<String> listOfDataService() {
    return remoteState.getNames(remoteState.periodState);
  }
}
