import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
class ServicePriceController extends GetxController{
  final remoteState = RemoteState();
    final storage = AppService.getStorage;
  final name = TextEditingController();
  var valueOfDropBox = ["",""];
  int? userID;
  final priceKey = GlobalKey<FormState>();
  @override
  void onInit() {
    checkFromUser();
    super.onInit();
    fetchData();
  }
  void fetchData() async {
    remoteState.servicesState.clear();
    remoteState.periodState.clear();
    remoteState.isLoading(true);
    try {
      final response = await Future.wait([
        remoteState.api.respone("${AppLinks.product}?op_type=select2&user_id=$userID"),
        remoteState.api.respone("${AppLinks.period}?op_type=select")
      ]);
    
        if (response[0] != null) {
        remoteState.servicesState.addAll(
            response[0]!.map((e) => Services.fromjson(e)).toList());
        remoteState.servicesState.refresh();
      }
  
        if (response[1] != null) {
        remoteState.periodState.addAll(
            response[1]!.map((e) => Period.fromjson(e)).toList());
        remoteState.periodState.refresh();
      }
    
    } finally {
      remoteState.isLoading(false);
    }
  }
  List<String> dropDownBoxData(int index){
    final data = [remoteState.getNames(remoteState.servicesState),remoteState.getNames(remoteState.periodState)];
    return data[index];
  }

  void periodRequest()async{
   if(priceKey.currentState!.validate()){
    await remoteState.api.request(AppLinks.priceOfService, {
        "op_type": "insert",
        "product_id": remoteState.getID(remoteState.servicesState, valueOfDropBox[0]).toString(),
        "timeperiod_id":remoteState.getID(remoteState.periodState, valueOfDropBox[1]).toString(),
        "pricing_price": name.text,
      },label: "عملية الاضافة");
   }
    clear();
  }
  void clear() {
    name.text = "";
    valueOfDropBox[0]="";
    valueOfDropBox[1]="";
    update();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      userID = storage!.read("userID");
      update();
    }
  }
}