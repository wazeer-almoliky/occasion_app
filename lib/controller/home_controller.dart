import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/section_service_binding.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/view/screens/section_service_screen.dart';

class HomeController extends GetxController {
  final remoteState = RemoteState();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    remoteState.serviceState.clear();
    remoteState.isLoading(true);
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

  void sectionServiceViewScreen({int? id, String? name, int? index}) async {
    final tr = [
      Transition.zoom,
      Transition.upToDown,
      Transition.downToUp,
      Transition.leftToRight,
      Transition.rightToLeft,
      Transition.rightToLeftWithFade,
      Transition.leftToRightWithFade,
      Transition.size,
      Transition.circularReveal
    ];
    Get.to(() => const SectionService(),
        binding: SectionServiceBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: tr[index!],
        arguments: {"id": id, "name": name});
  }

  @override
  void onClose() {
    super.onClose();
    remoteState.isLoading(false);
  }
}
