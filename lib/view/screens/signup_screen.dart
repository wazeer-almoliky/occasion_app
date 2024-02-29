import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/signup_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<SignUpController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: DAppBar(
          title: "",
          back: AppColors.secondary,
          isHasSetting: false,
          front: AppColors.primary,
        ),
        body: SafeArea(
            child: ListView(
              physics:const BouncingScrollPhysics(),
              padding:const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              children: [
               Form(
              key: outerController.signUpKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // shrinkWrap: true,
                // physics:const NeverScrollableScrollPhysics(),
                children: [
                 
                  const SizedBox(
                    height: 60,
                  ),
                  CustomText(
                    text: "انشــاء حســــاب",
                    fontFamily: ArabicFont.dinNextLTArabic,
                    alignment: Alignment.center,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                 ...List.generate(InputFieldData.signUp.length, (index) {
                    return GetBuilder<SignUpController>(
                        builder: (innerController) {
                      return InputField(
                        label: InputFieldData.signUp[index].label,
                        hint: InputFieldData.signUp[index].label,
                        suffixIcon: index != 1
                            ? Icon(InputFieldData.signUp[index].icon)
                            : IconButton(
                                onPressed: () {
                                  innerController.enablePassword();
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                        controller: outerController.listOfController(index),
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        isPassword: innerController.isEnablePassword&& index == 1,
                        isNumber: InputFieldData.signUp.length - 1 == index,
                        labelColor: AppColors.primary,
                        onValid: (val) {
                          return FormValidations.checkValidations(
                              val!,
                              InputFieldData.signUp[index].min!,
                              InputFieldData.signUp[index].max!);
                        },
                      );
                    });
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onPressed: () async {
                      outerController.signUp();
                    },
                    text: "حفــــــــظ",
                    buttonColor: AppColors.primary,
                      textColor: AppColors.secondary,
                    margin: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 35),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    fontSize: 25,
                    fontFamily: ArabicFont.elMessiri,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
              ],
            )),
      ),
    );
  }
}
