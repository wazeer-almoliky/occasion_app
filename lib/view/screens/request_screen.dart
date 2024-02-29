import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/request_controller.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_dialog.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<ResquestController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: "الحجــوزات",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 25),
        child: Obx(() {
          if (outerController.remoteState.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final user = outerController.admin == "ادمن"
                ? outerController.remoteState.userState
                    .where((user) =>
                        user.state == 0 && outerController.userState == 0)
                    .toList()
                : outerController.remoteState.reserveState
                    .where((res) =>
                        res.state == 0 && outerController.userState == 0)
                    .toList();
            final user2 = outerController.admin == "ادمن"
                ? outerController.remoteState.userState
                    .where((user) =>
                        user.state == 1 && outerController.userState == 1)
                    .toList()
                : outerController.remoteState.reserveState
                    .where((res) =>
                        res.state == 1 && outerController.userState == 1)
                    .toList();

            if (user.isEmpty && outerController.userState == 0) {
              return const Center(
                child: CustomText(
                  text: "لا يوجــد",
                  fontSize: 22,
                ),
              );
            }
            if (user2.isEmpty && outerController.userState == 1) {
              return const Center(
                child: CustomText(
                  text: "لا يوجــد",
                  fontSize: 22,
                ),
              );
            } else {
              return ListView.builder(
                itemCount:
                    outerController.userState == 1 ? user2.length : user.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration:const BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        border:  Border(
                            bottom: BorderSide(
                                color: AppColors.blackColor, width: 3.2)),
                        // color: AppColors.secondary
                        
                        ),
                    child: Material(
                      color: AppColors.transparentColor,
                      child: InkWell(
                        onTap: () {
                          // log("${user[index].id}==${user[index].name}==${user[index].state}");
                        },
                        splashColor: const Color.fromARGB(255, 189, 189, 189),
                        borderRadius: BorderRadius.circular(35),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomText(
                                  text: outerController.userState == 1
                                      ? user2[index].name!
                                      : user[index].name!,
                                  colorText: AppColors.primary,
                                  fontFamily: ArabicFont.elMessiri,
                                  fontSize: 20,
                                ),
                                if (outerController.userState == 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                        decoration: BoxDecoration(
                                            // color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: InkWell(
                                            child: Row(
                                          children: List.generate(2, (index2) {
                                            return CustomButton(
                                              onPressed: () async {
                                                if (index2 == 0) {
                                                  if (outerController.admin ==
                                                      "ادمن") {
                                                    CustomAlertDialog
                                                        .demoDetail(
                                                      user[index].name!,
                                                      user[index].state!,
                                                      user[index].id!,
                                                      isNotAdmin: false,
                                                    );
                                                    log("admin");
                                                  } else {
                                                    log("user");
                                                    //
                                                    // log("010${outerController.remoteState.reserveState[index].id!}");
                                                    CustomAlertDialog
                                                        .demoDetail(
                                                      outerController
                                                          .remoteState
                                                          .reserveState[index]
                                                          .name!,
                                                      outerController
                                                          .remoteState
                                                          .reserveState[index]
                                                          .state!,
                                                      outerController
                                                          .remoteState
                                                          .reserveState[index]
                                                          .id!,
                                                      count: outerController
                                                          .remoteState
                                                          .reserveState[index]
                                                          .quentity,
                                                      date: outerController
                                                          .remoteState
                                                          .reserveState[index]
                                                          .date
                                                          .toString()
                                                          .substring(0, 10),
                                                      isNotAdmin: true,
                                                    );
                                                  }
                                                } else {
                                                  // log("Phone Number :${user[index].phone}");
                                                  final phone =
                                                      outerController.admin ==
                                                              "ادمن"
                                                          ? user[index].phone
                                                          : user[index].phone;
                                                  log("Phone Number :$phone");
                                                  final url = Uri(
                                                      scheme: "tel",
                                                      path: "$phone");
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                }
                                              },
                                              text: index2 == 0
                                                  ? "تــأكيــد"
                                                  : "اتصـــال",
                                              radius: 10,
                                              buttonColor: AppColors.primary,
                                              textColor: AppColors.secondary,
                                              fontSize: 19,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                            );
                                          }),
                                        )),
                                      ),
                                    ],
                                  ),
                                if (outerController.userState == 1 &&
                                    outerController.admin == "ادمن")
                                  Center(
                                    child: CustomButton(
                                      onPressed: () {
                                        log("${outerController.remoteState.userState[index].id!}");
                                        outerController.updateUser(
                                            outerController.remoteState
                                                .userState[index].id!,
                                            disableUser: 0,
                                            hint: "الايقــاف");
                                      },
                                      text: "ايقـــاف",
                                      radius: 10,
                                      buttonColor: AppColors.primary,
                                      textColor: AppColors.secondary,
                                      fontSize: 19,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15),
                                    ),
                                  ),
                              ],
                            )),
                      ),
                    ),
                  );
                },
              );
            }
          }
        }),
      ),
    );
  }
}
