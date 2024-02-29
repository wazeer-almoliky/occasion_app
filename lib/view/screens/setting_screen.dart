import 'package:arabic_font/arabic_font.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/stting_controller.dart';
import 'package:occasion_app/utilities/classes/custom_color_picker.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  void reload(){
    Get.put(SettingController()).getPrimaryColor();
    Get.put(SettingController()).update();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: "الإعـــدادات",
        back: AppColors.primary,
        front: AppColors.secondary,
      ),
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<SettingController>(
                init: SettingController(),
                builder: (innerController) {
                  return ListTile(
                    onTap: () async {
                      CustomDatePicker.showColor().then((value) {
                        innerController.changeColor(value);
                        innerController.update();
                      });
                      reload();
                    },
                    title: CustomText(
                      text: "تغيير اللـون الأساسي",
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 18,
                      colorText: AppColors.primary,
                    ),
                    leading: const Icon(
                      Icons.color_lens,
                      size: 28,
                    ),
                    trailing: ColorIndicator(
                        width: 40,
                        height: 40,
                        borderRadius: 0,
                        color: Color(innerController.mainColor),
                        elevation: 1,
                        onSelectFocus: false,
                        onSelect: () async {
                          CustomDatePicker.showColor().then((value) {
                            innerController.changeColor(value);
                            innerController.update();
                          });
                          reload();
                        }),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
           GetBuilder<SettingController>(
                init: SettingController(),
                builder: (innerController) {
                  return ListTile(
                    onTap: () async {
                      CustomDatePicker.showColor().then((value) {
                        innerController.changeColor2(value);
                        innerController.update();
                      });
                      reload();
                    },
                    title: CustomText(
                      text: "تغيير اللـون الثانوي",
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 18,
                      colorText: AppColors.primary,
                    ),
                    leading: const Icon(
                      Icons.color_lens,
                      size: 28,
                    ),
                    trailing: ColorIndicator(
                        width: 40,
                        height: 40,
                        borderRadius: 0,
                        color: Color(innerController.mainColor2),
                        elevation: 1,
                        onSelectFocus: false,
                        onSelect: () async {
                          CustomDatePicker.showColor().then((value) {
                            innerController.changeColor2(value);
                            innerController.update();
                          });
                          reload();
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
