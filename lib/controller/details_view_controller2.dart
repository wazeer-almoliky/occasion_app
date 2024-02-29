import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/reserv_binding.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/classes/custom_dialog.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/reserve_screen.dart';
import 'package:occasion_app/view/widgets/customer_bottom_sheet.dart';

class DetailsViewController2 extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final userName = TextEditingController();
  final phone = TextEditingController();
  final userKey = GlobalKey<FormState>();
  int? id;
  String? name;
  @override
  void onInit() {
    remoteState.photoState.clear();
    remoteState.reserveState.clear();
    super.onInit();
    id = Get.arguments["id"];
    name = Get.arguments["name"];
    fetchData();
    //  Get.find<ReserveController>();
  }

  void fetchData() async {
    log("category ID>> $id");
    try {
      final product = await remoteState.api
          .respone("${AppLinks.product}?op_type=select&giver_id=$id");
      if (product != null) {
        remoteState.servicesState
            .addAll(product.map((e) => Services.fromjson(e)).toList());
        remoteState.servicesState.refresh();
      }
      final photo =
          await remoteState.api.respone("${AppLinks.photo}?op_type=select&product_id=$id");
      if (photo != null) {
        remoteState.photoState
            .addAll(photo.map((e) => Photo.fromjson(e)).toList());
        remoteState.photoState.refresh();
      }
      final productPrice =
          await remoteState.api.respone("${AppLinks.priceOfService}?op_type=select&product_id=$id");
      if (productPrice != null) {
         log("PRICE>>$productPrice null");
        remoteState.priceState
            .addAll(productPrice.map((e) => Price.fromjson(e)).toList());
        remoteState.priceState.refresh();
        //log("PRICE>>$productPrice");
      }
      log("PRICE>>$productPrice");
      final res = await remoteState.api
          .respone("${AppLinks.reserve}?op_type=reserve_date&product_id=$id");
      if (res != null) {
        remoteState.reserveState
            .addAll(res.map((e) => Reserve.fromjson(e)).toList());
        remoteState.reserveState.refresh();
      }
    } finally {
      //remoteState.isLoading(false);
    }
  }

  void detailsViewScreen({int? id, String? name,int? price}) async {
    Get.to(() => const ReserveScreen(),
        binding: ReserveBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.downToUp,
        arguments: {"id": id, "name": name,"price":price});
  }

  void checkFromUser(int id, String name,int price) {
    if (userKey.currentState!.validate()) {
      storage!.write("customerName", userName.text);
      storage!.write("customerPhone", phone.text);
      CustomAlertDialog.showSnackBar("تم حفــظ البيـانات", size: 20);
      CustomerButtomSheet.customerSheet(id, price,title: name);
    }
  }

  TextEditingController listOfController(int index) {
    final controller = [userName, phone];
    return controller[index];
  }
}
