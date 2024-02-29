import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/section_service_cpntroller.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class SectionService extends StatelessWidget {
  const SectionService({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<SectionServiceController>();
    return Scaffold(
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.primary,
        front: AppColors.secondary,
      ),
      body: Center(
        child: Obx(() {
          if (outerController.remoteState.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = outerController.remoteState.givserState
                .where((s) => s.serviceID == outerController.id)
                .toList();
            return data.isEmpty
                ?  CustomText(
                    text: "لا يوجـــد بيانــات",
                    fontSize: 20,
                    colorContainer: AppColors.secondary,
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, right: 12, left: 12),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.secondary),
                                child: Material(
                                  color: AppColors.transparentColor,
                                  child: InkWell(
                                    splashColor: const Color.fromARGB(
                                        255, 189, 189, 189),
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: (){
                                      outerController.detailsViewScreen(id: data[index].id!,name: data[index].name!);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: data[index].name!,
                                          fontFamily: ArabicFont.avenirArabic,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          colorText: AppColors.primary,
                                        ),
                                       const SizedBox(height: 12,),
                                        CustomText(
                                          text: data[index].address!,
                                          fontFamily: ArabicFont.avenirArabic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          colorText: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }
        }),
      ),
    );
  }
}
