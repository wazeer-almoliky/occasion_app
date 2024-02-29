import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
class SettingController extends GetxController{
  var mainColor = 0xff010B1F;
  var mainColor2 = 0xffDEC371;
  final storage = AppService.getStorage;

  @override
  void onInit() {
    super.onInit();
    getPrimaryColor();
  }
  Future<void> changeColor(Color color) async {
    mainColor = color.value;
    storage!.write("primary",color.value);
    update();
  }
  Future<void> changeColor2(Color color) async {
    mainColor2 = color.value;
    storage!.write("secondary",color.value);
    update();
  }
  void getPrimaryColor()async{
    if(storage!.read("primary") !=null){
      mainColor= storage!.read("primary");
      update();
    }
    if(storage!.read("secondary") !=null){
      mainColor2= storage!.read("secondary");
      update();
    }
  }

  void refresh2(){
    
  }
}