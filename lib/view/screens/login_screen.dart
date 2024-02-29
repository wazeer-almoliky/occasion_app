import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/binding/signup_binding.dart';
import 'package:occasion_app/controller/login_controller.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';
import 'package:occasion_app/view/screens/signup_screen.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<LoginController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: DAppBar(
          title: "",
          isHasSetting: false,
          back: AppColors.secondary,
          front: AppColors.primary,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Form(
                key: outerController.loginKey,
                child: Column(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CustomText(
                      text: "تسجيــل الدخــول",
                      fontFamily: ArabicFont.dinNextLTArabic,
                      alignment: Alignment.center,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      colorText: AppColors.primary,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                   ...List.generate(
                        2,
                        (index) => GetBuilder<LoginController>(builder: (innerController){
                          return InputField(
                              label: index == 0
                                  ? "اسـم المستخـدم"
                                  : "كلمـة المـرور",
                              hint: index == 0
                                  ? "اسـم المستخـدم"
                                  : "كلمـة المـرور",
                              controller:
                                  outerController.listOfController(index),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              suffixIcon:index==0? const Icon(Icons.person_outline):IconButton(onPressed: (){
                                innerController.enablePassword();
                              }, icon:const Icon(Icons.remove_red_eye)),
                              isNumber: false,
                              isPassword:innerController.isEnablePassword&&index==1,
                              labelColor: AppColors.primary,
                              onValid: (val) {
                                return FormValidations.checkValidations(
                                    val!, index==0?15:4, index==1?50:50);
                              },
                            );
                        })
                            ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () async {
                  outerController.login();
                  // outerController.checkApi();
                },
                text: "دخـــــول",
                buttonColor: AppColors.primary,
                textColor: AppColors.secondary,
                margin:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 35),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                fontSize: 22,
                fontFamily: ArabicFont.dinNextLTArabic,
                fontWeight: FontWeight.bold,
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Get.off(() => const SignUpScreen(),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.ease,
                        transition: Transition.upToDown,
                        binding: SignUpBinding());
                    //outerController.checkApi();
                  },
                  child: CustomText(
                    text: "لا أمتلك حســــاب بالفعل ؟",
                    alignment: Alignment.center,
                    fontFamily: ArabicFont.dubai,
                    fontSize: 18,
                    colorText: AppColors.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
