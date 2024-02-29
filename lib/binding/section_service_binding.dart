import 'package:get/get.dart';
import 'package:occasion_app/controller/section_service_cpntroller.dart';

class SectionServiceBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SectionServiceController(),fenix: true);
  }
  
}