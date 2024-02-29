import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/model/remote/api_model.dart';
import 'package:occasion_app/model/remote/remote_state.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/product_section.dart';

class SectionServiceController extends GetxController{
   final remoteState = RemoteState();
  final storage=  AppService.getStorage;
  int? id;
  String? name;
  @override
  void onInit() {
    super.onInit();
    id =Get.arguments["id"];
    name =Get.arguments["name"];
    fetchData();

  }
  void fetchData()async{
    remoteState.givserState.clear();
    // remoteState.isLoading(true);
    try {
    final response = await remoteState.api.respone("${AppLinks.givenService}?op_type=select&service_id=$id");
    if(response !=null){
      remoteState.givserState.addAll(response.map((e) => GivserService.fromjson(e)).toList());
      remoteState.givserState.refresh();
    }
    } finally {
      // remoteState.isLoading(false);
    }
  }
  void detailsViewScreen({int? id,String? name}) async {
    Get.to(() => const ProductSection(),
        // binding: DetailsViewBinding2(),
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        transition: Transition.circularReveal,
        arguments: {"id":id,"name":name}
        );
  }
}