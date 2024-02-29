import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/binding/initial_data_binding.dart';
import 'package:occasion_app/binding/request_binding.dart';
import 'package:occasion_app/binding/service_binding.dart';
import 'package:occasion_app/binding/service_price_binding.dart';
import 'package:occasion_app/binding/user_binding.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/add_service.dart';
import 'package:occasion_app/view/screens/initia_data_screen.dart';
import 'package:occasion_app/view/screens/request_screen.dart';
import 'package:occasion_app/view/screens/service_period_screen.dart';
import 'package:occasion_app/view/screens/service_price_screen.dart';
import 'package:occasion_app/view/screens/services_screen.dart';
import 'package:occasion_app/view/screens/user_screen.dart';

class DashboardController extends GetxController {
  RxBool isVisible = true.obs;
  ScrollController scrollController = ScrollController();
  final storage = AppService.getStorage;
  var admin = "";

  @override
  void onInit() {
    super.onInit();
    checkFromUser();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      update();
    }
  }

  void pages(int index, {bool? isFromAdmin = false}) {
      if (index == 0) {
        if(admin == "عادي"){
          go(const InitialDataScreen(),
            transition: Transition.zoom, binding: InitialData());
        }else{
          go(const UserScreen(),
            transition: Transition.rightToLeft, binding: UserBinding());
        }
        
      }
      if (index == 1) {
        go(const ServicesScreen(),
            transition: Transition.leftToRightWithFade,
            binding: ServiceBinding(),
            arguments: {"productID":0,"photoID":0});
      }
      if (index == 2) {
        go(const AddService(),
            transition: Transition.upToDown, binding: ServiceBinding(),
            arguments: {"productID":0,"photoID":0});
      }
      if (index == 3) {
        //
        go(admin == "عادي" ? const ServicePrice() : const ServicePeriod(),
            transition: Transition.downToUp,
            binding:
                admin == "عادي" ? ServicePriceBinding() : ServiceBinding(),
                arguments: {"productID":0,"photoID":0});
      }
      if (index == 4) {
        go(const RequestScreen(),
            transition: Transition.rightToLeftWithFade,
            binding: RequestBinding(),
            arguments: {"userState": 0});
      }
      if (index == 5) {
        go(const RequestScreen(),
            transition: Transition.leftToRightWithFade,
            binding: RequestBinding(),
            arguments: {"userState": 1});
      }
     
  }

  void go(dynamic page,
      {Transition? transition, Bindings? binding, dynamic arguments}) async {
    await Get.to(page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
      transition: transition,
      binding: binding,
      arguments: arguments,
    );
  }

  add()async{
    await Get.to(()=>const AddService(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      transition: Transition.circularReveal,
      binding: ServiceBinding(),
      arguments: {"productID":0,"photoID":0}
    );
  }
}
