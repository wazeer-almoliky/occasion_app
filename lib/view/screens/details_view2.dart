import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/controller/details_view_controller2.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';
import 'package:occasion_app/view/widgets/customer_bottom_sheet.dart';
import 'package:occasion_app/view/widgets/normal_user_widget.dart';
import 'package:photo_view/photo_view.dart';

class DetailsView2 extends StatelessWidget {
  const DetailsView2({super.key});
  void reload() {
    Get.find<DetailsViewController2>().remoteState.photoState.clear();
    Get.find<DetailsViewController2>().remoteState.servicesState.clear();
  }

  @override
  Widget build(BuildContext context) {
    // reload();
    final outerController =
        Get.put<DetailsViewController2>(DetailsViewController2());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.primary,
        front: AppColors.secondary,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              // if (outerController.remoteState.servicesState.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CustomText(
                    text: " الخدمــة:",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: outerController.name!,
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CustomText(
                    text: "السعــر:",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  Obx(() => CustomText(
                        //outerController.remoteState.priceState[0].price
                        text:
                            "${outerController.remoteState.priceState[0].price}",
                        fontFamily: ArabicFont.avenirArabic,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      )),
                  // CustomText(//outerController.remoteState.priceState[0].price
                  //   text:
                  //       "${outerController
                  //                     .remoteState.priceState[0].price}",
                  //   fontFamily: ArabicFont.avenirArabic,
                  //   fontSize: 23,
                  //   fontWeight: FontWeight.bold,
                  // )
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              // if (outerController.remoteState.servicesState.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    2,
                    (index) => CustomButton(
                          onPressed: () {
                            if (index == 0) {
                              if (outerController.storage!
                                      .read("customerName") !=
                                  null) {
                                CustomerButtomSheet.customerSheet(
                                    outerController.id ?? 0,
                                    outerController
                                            .remoteState.priceState[0].price ??
                                        1,
                                    title: outerController.name);
                              } else {
                                log("101${outerController.remoteState.servicesState[0].id}");
                                NormalUserWidget.normalUser(
                                    outerController.id ?? 0,
                                    outerController
                                        .remoteState.priceState[0].price!,
                                    outerController.name!);
                              }
                            } else {
                              // if (outerController.storage!
                              //         .read("customerName") !=
                              //     null) {
                              //   CustomerButtomSheet.reserveDate();
                              // }
                              CustomerButtomSheet.reserveDate();
                            }
                          },
                          text:
                              index == 0 ? "احجـــز الآن" : " التأريخ المتوفر",
                          fontFamily: ArabicFont.avenirArabic,
                          fontSize: 20,
                          radius: 12,
                          fontWeight: FontWeight.bold,
                          buttonColor: AppColors.secondary,
                          textColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 2,
                  children: List.generate(
                      outerController.remoteState.photoState.length,
                      (index) => Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: AppColors.grayColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: PhotoView(
                              imageProvider: NetworkImage(
                                  "${AppLinks.upload}/${outerController.remoteState.photoState[index].name!}"),
                            ),
                          )),
                );
              }),
            ],
          )),
    );
  }
}
