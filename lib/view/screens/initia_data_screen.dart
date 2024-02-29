import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/initial_data_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_drop_down_search.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';

class InitialDataScreen extends GetView<InitialDataControllrt> {
  const InitialDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<InitialDataControllrt>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.primary,
        elevation: 0.0,
        toolbarHeight: 100,
        flexibleSpace: ClipPath(
          clipper: PointsClipper(),
          child: Container(
            height: 120,
            width: Get.width,
            color: AppColors.secondary,
            child:  Center(
                child: CustomText(
              text: "البيانــات الأسـاسيـة",
              fontFamily: ArabicFont.tajawal,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              colorText: AppColors.primary,
            )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 40),
          child: Form(
              key: controller.initialDataKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(() {
                    if (outerController.remoteState.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CustomDropDownSearch(
                        items: outerController.listOfDataService(),
                        // labelText: "نــوع الخدمـة",
                        hintText: "نــوع الخدمـة",
                        margin: const EdgeInsets.only(bottom: 25),
                        onChanged: (val) {
                          if (val != null) {
                            outerController.serviceID = val;
                            log("$val");
                            outerController.update();
                          }
                        },
                      );
                    }
                  }),
                  ...List.generate(
                    InputFieldData.initScreen.length,
                    (index) => InputField(
                        controller: controller.listOfController(index),
                        label: InputFieldData.initScreen[index].label,
                        hint: InputFieldData.initScreen[index].label,
                        suffixIcon: Icon(InputFieldData.initScreen[index].icon),
                        isReadOnly: false,
                        isNumber: index > 1,
                        onValid: (val) {
                          return FormValidations.checkValidations(
                              val!,
                              InputFieldData.initScreen[index].min!,
                              InputFieldData.initScreen[index].max!,
                              isValid: index > 1);
                        },
                        margin: const EdgeInsets.only(bottom: 35)),
                  ),
                  CustomButton(
                    onPressed: () {
                      controller.login();
                    },
                    text: "حفـــــظ",
                    fontFamily: ArabicFont.changa,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    buttonColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
