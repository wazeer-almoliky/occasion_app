import 'package:get/get.dart';
import 'package:occasion_app/controller/details_view_controller2.dart';
class DetailsViewBinding2 extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsViewController2(),fenix: false);
  }
  
}