import 'package:get/get.dart';
import 'package:occasion_app/controller/details_view_controller.dart';
class DetailsViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsViewController());
  }
  
}