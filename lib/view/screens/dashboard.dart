import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/dashboard_controller.dart';
import 'package:occasion_app/model/static/dashboard_model.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<DashboardController>();
    return Scaffold(
      backgroundColor:
          AppColors.whiteColor, //"إدارة التحكــم ${outerController.admin}"
      appBar: DAppBar(
        title: "إدارة التحكــم",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          childAspectRatio: 2 / 1,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          cacheExtent: 3 / 2,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
              outerController.admin == "ادمن"
                  ? DashBoardData.admin.length
                  : DashBoardData.user.length, (index) {
            final color = [
              const Color.fromARGB(255, 36, 144, 40),
              const Color.fromARGB(255, 12, 135, 235),
              const Color.fromARGB(255, 129, 39, 32),
              const Color.fromARGB(255, 82, 68, 63),
              const Color.fromARGB(255, 241, 148, 9),
              Colors.purple
            ];
            return InkWell(
              onTap: () {
                outerController.pages(index);
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                    color: color[index],
                    borderRadius: BorderRadius.circular(15)),
                child: CustomText(
                  text: outerController.admin == "عادي"
                      ? DashBoardData.user[index].label!
                      : DashBoardData.admin[index].label!,
                  fontFamily: ArabicFont.tajawal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.whiteColor,
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.transparentColor,
        elevation: 0.0,
        onPressed: () {
          // CustomAlertDialog.show();
          outerController.add();
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
