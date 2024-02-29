import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/binding/home_binding.dart';
import 'package:occasion_app/binding/login_binding.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/constants/app_images.dart';
import 'package:occasion_app/view/screens/home_screen.dart';
import 'package:occasion_app/view/screens/login_screen.dart';

class UserDecided extends StatelessWidget {
  const UserDecided({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Image(
            image: const AssetImage(AppImages.logo),
            width: Get.width,
            height: Get.height / 2,
            fit: BoxFit.contain,
          ),
          ...List.generate(
              2,
              (index) => CustomButton(
                    onPressed: () {
                      if (index == 0) {
                        Get.to(() => const HomeScreen(),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                            transition: Transition.zoom,
                            binding: HomeBinding());
                      } else {
                        Get.to(() => const LoginScreen(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            transition: Transition.leftToRight,
                            binding: LoginBinding());
                      }
                    },
                    text: index == 0
                        ? "الدخـول كزائــر"
                        : "الدخـول بحسـاب أعمـال",
                    buttonColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    margin: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 35),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    fontSize: 19,
                    fontFamily: ArabicFont.dinNextLTArabic,
                    fontWeight: FontWeight.bold,
                  ))
        ],
      )),
    );
  }
}
