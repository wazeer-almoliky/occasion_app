import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/screens/setting_screen.dart';
class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? back, front;
  final bool? isHasSetting;
  final double? height;
  const DAppBar(
      {super.key, this.title, this.back, this.front, this.isHasSetting = true,this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0.0,
      toolbarHeight: height??140,
      backgroundColor: AppColors.whiteColor,
      automaticallyImplyLeading: true,
      flexibleSpace: ClipPath(
        clipper: PointsClipper(),
        child: Container(
          height: height??150,
          width: Get.width,
          color: front,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           if (isHasSetting == true)   const Spacer(
                flex: 2,
              ),
              Center(
                  child: CustomText(
                text: title!,
                fontFamily: ArabicFont.tajawal,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                colorText: back,
              )),
             if (isHasSetting == true) const Spacer(),
              if (isHasSetting == true)
                IconButton(
                    onPressed: () {
                      Get.to(() => const SettingScreen(),
                          duration: const Duration(milliseconds: 550),
                          curve: Curves.ease,
                          transition: Transition.upToDown);
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 35,
                      color: AppColors.whiteColor,
                    )),
                if (isHasSetting == true)  const  SizedBox(width: 30,),
              // if (isHasSetting == true)  IconButton(
              //       onPressed: () {
              //         Get.to(() => const LoginScreen(),
              //               duration: const Duration(milliseconds: 600),
              //               curve: Curves.ease,
              //               transition: Transition.leftToRight,
              //               binding: LoginBinding());
              //       },
              //       icon: const Icon(
              //         Icons.person_rounded,
              //         size: 35,
              //         color: AppColors.whiteColor,
              //       )),
                    const  SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, kToolbarHeight * 2);
}
