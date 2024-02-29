import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/binding/service_binding.dart';
import 'package:occasion_app/controller/details_view_controller.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/screens/service_update_screen.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';
import 'package:photo_view/photo_view.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<DetailsViewController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(2, (index) {
                  return CustomText(
                    text: index == 0 ? "اســـم الخدمــة:" : "معلومـــات",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(
                        outerController.remoteState.servicesState.length,
                        (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            text: outerController
                                .remoteState.servicesState[index].name!,
                            fontSize: 17,
                            fontFamily: ArabicFont.avenirArabic,
                            margin: const EdgeInsets.only(bottom: 12),
                          ),
                          CustomText(
                            text: outerController
                                .remoteState.servicesState[index].note!,
                            fontSize: 17,
                            fontFamily: ArabicFont.avenirArabic,
                            margin: const EdgeInsets.only(bottom: 12),
                          ),
                        ],
                      );
                    })
                  ],
                );
              }),
              const Divider(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              if (outerController.user != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    final label = ["إضــافة صور", "تعديــل"];
                    return CustomButton(
                      onPressed: () {
                        if (index == 0) {
                          Get.to(() => const UpdateServiceScreen(),
                              duration: const Duration(milliseconds: 400),
                              binding: ServiceBinding(),
                              curve: Curves.ease,
                              transition: Transition.fadeIn,
                              arguments: {
                                "prID": outerController
                                    .remoteState.servicesState[0].id,
                                "photoID": 1,
                                "label": "تعديــل",
                                "serviceName":
                                    "${outerController.remoteState.servicesState[0].name}"
                              });
                        } else {
                          Get.to(() => const UpdateServiceScreen(),
                              duration: const Duration(milliseconds: 400),
                              binding: ServiceBinding(),
                              curve: Curves.ease,
                              transition: Transition.fadeIn,
                              arguments: {
                                "productID": outerController
                                    .remoteState.servicesState[0].id,
                                "photoID": 0,
                                "label": "اضافة صـور",
                                "serviceName":
                                    "${outerController.remoteState.servicesState[0].name}"
                              });
                        }
                      },
                      text: label[index],
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 20,
                      radius: 7,
                      fontWeight: FontWeight.bold,
                      buttonColor: AppColors.secondary,
                      textColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    );
                  }),
                ),
              const SizedBox(
                height: 20,
              ),
              // if (outerController.user != "ادمن")
              Obx(() {
                final data = outerController.remoteState.photoState
                    .where((p) =>
                        p.serviceID ==
                        outerController.remoteState.servicesState[0].id)
                    .toList();
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 2,
                  children: List.generate(
                      data.length,
                      (index) => InkWell(
                            onTap: () {
                              Get.to(() => const UpdateServiceScreen(),
                                  duration: const Duration(milliseconds: 400),
                                  binding: ServiceBinding(),
                                  curve: Curves.ease,
                                  transition: Transition.fadeIn,
                                  arguments: {
                                    "prID": outerController
                                        .remoteState.servicesState[0].id,
                                    "photoID": data[index].id,
                                    "label": "تعديــل",
                                    "serviceName":
                                        "${outerController.remoteState.servicesState[0].name}"
                                  });
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: AppColors.grayColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: PhotoView(
                                imageProvider: NetworkImage(
                                    "${AppLinks.upload}/${data[index].name!}"),
                              ),
                            ),
                          )),
                );
              }),
            ],
          )),
    );
  }
}
