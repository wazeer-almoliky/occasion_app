import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/user_controller.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/screens/update_screen.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class UserScreen extends StatelessWidget {
  //Get.forceAppUpdate();
  void reload() {
    Get.find<UserController>().remoteState.userState.clear();
  }

  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //reload();
    final outerController = Get.find<UserController>();
    return Scaffold(
      appBar: DAppBar(
        title: "المــدراء",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Obx(() {
            if (outerController.remoteState.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final user = outerController.remoteState.userState
                  .where((u) => u.type == "ادمن")
                  .toList();
              return ListView.builder(
                  itemCount: user.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration:const BoxDecoration(
                          //color: AppColors.secondary,
                          //borderRadius: BorderRadius.circular(10),
                          border: Border(bottom: BorderSide(color: AppColors.blackColor,width: 3.2))
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            text: user[index].name!,
                            fontSize: 20,
                            fontFamily: ArabicFont.avenirArabic,
                            // fontoccasion_app: ArabicFont.avenirArabic,
                          ),
                          IconButton(
                              onPressed: () {
                                Get.to(() => const UpdateScreen(),
                                    duration: const Duration(milliseconds: 400),
                                    transition: Transition.fadeIn,
                                    curve: Curves.ease,
                                    arguments: {
                                      "label": "تعديل",
                                      "userID": user[index].id!,
                                      "name": user[index].name!
                                    });
                              },
                              icon:const Icon(Icons.edit,size: 40,)),
                          IconButton(
                              onPressed: () {
                                outerController.deleteUser(user[index].id!);
                              },
                              icon:const Icon(Icons.delete,size: 40,)),
                        ],
                      ),
                    );
                  });
            }
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.transparentColor,
        elevation: 0.0,
        onPressed: () {
          // CustomAlertDialog.show();
          Get.off(() => const UpdateScreen(),
              duration: const Duration(milliseconds: 400),
              transition: Transition.fadeIn,
              curve: Curves.ease,
              arguments: {"label": "اضافة", "userID": 0, "name": ""});
        },
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.add,
            color: AppColors.secondary,
            size: 50,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        //color: AppColors.primary,
        child: BottomAppBar(
          notchMargin: 8.0,
          color: AppColors.secondary,
          clipBehavior: Clip.hardEdge,
          surfaceTintColor: AppColors.primary,
          shape: const CircularNotchedRectangle(),
        ),
      ),
    );
  }
}
