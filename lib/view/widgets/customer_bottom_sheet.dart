import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/details_view_controller2.dart';
import 'package:occasion_app/controller/reserve_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_date_picker.dart';
import 'package:occasion_app/utilities/classes/custom_drop_down_search.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';

class CustomerButtomSheet {
  static final controller = Get.put(ReserveController());
  static final controller2 = Get.put(DetailsViewController2());
  static void customerSheet(int id,int price,{String? title}) async {
    await Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: Get.height - 150,
          // color: AppColors.grayColor,
          child: Column(
            children: [
              CustomText(
                text: "حجـــز $title",
                fontSize: 27,
                fontFamily: ArabicFont.avenirArabic,
                fontWeight: FontWeight.bold,
                colorText: AppColors.primary,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2.2,
                thickness: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisSize: MainAxisSize.min,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: controller.reserveKey,
                      child: Column(
                        children: List.generate(InputFieldData.customerPeriod.length,
                            (index) {
                          return InputField(
                            controller: controller.listOfController(index),
                            label: InputFieldData.customerPeriod[index].label,
                            hint: InputFieldData.customerPeriod[index].label,
                            suffixIcon:
                                Icon(InputFieldData.customerPeriod[index].icon),
                            isNumber: index > 0,
                            isReadOnly:
                                InputFieldData.customerPeriod.length - 1 == index,
                            onTap: () async {
                              if (InputFieldData.customerPeriod.length - 1 == index) {
                                final date = await CustomDatePicker.showDate();
                                controller.date.text =
                                    date.toString().substring(0, 10);
                                controller.update();
                              }
                            },
                            onValid: (val) {
                              return FormValidations.checkValidations(
                                  val!,
                                  InputFieldData.customerPeriod[index].min!,
                                  InputFieldData.customerPeriod[index].max!);
                            },
                            onChanged: (val) {
                              if (index == 3) {
                                controller.price(int.tryParse(val)??0);
                              }
                            },
                          );
                        }),
                      ),
                    ),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ...List.generate(
                            2,
                            (index) => Obx(() {
                                  return CustomDropDownSearch(
                                    items: controller.listOfString(index),
                                    labelText:
                                        index == 0 ? "الفتــرة" : "طــرق الدفع",
                                    hintText: index == 0 ? "الفتــرة" : "طــرق الدفع",
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    onChanged: (val) {
                                      if (val == null) {
                                        return;
                                      }
                                      if (index == 0) {
                                        final pID = controller.remoteState.getID(controller.remoteState.periodState, val);
                                        controller.price(
                                            controller.remoteState.getPrice(pID,id),
                                            isFromDrop: true);
                                      log("Price: ${controller.remoteState.getPrice(pID,id)}");
                                        controller.listOfDropBoxValue[index] = val;
                                      } else {
                                        controller.listOfDropBoxValue[index] = val;
                                      }
                                    },
                                  );
                                })),
                        const SizedBox(
                          height: 20,
                        ),
                        // GetBuilder<ReserveController>(builder: (innerController){
                        //   return CustomText(
                        //   text: "السعــر : ${innerController.value}",
                        //   fontSize: 20,
                        //   fontFamily: ArabicFont.avenirArabic,
                        // );
                        // }),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            Get.back();
                            controller.request(id,price);
                          },
                          text: "حجـــز",
                          fontFamily: ArabicFont.avenirArabic,
                          fontSize: 20,
                          buttonColor: AppColors.secondary,
                          textColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true,
        elevation: 1.5,
        useRootNavigator: true,
        enterBottomSheetDuration: const Duration(milliseconds: 450),
        exitBottomSheetDuration: const Duration(milliseconds: 450),
        backgroundColor: AppColors.grayColor);
  }

  static void reserveDate() async {
    await Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          height: Get.height - 220,
          child: controller.remoteState.reserveState.isEmpty
              ? const Center(
                  child: CustomText(
                    text: "لا يوجد حجـوزات",
                    fontFamily: ArabicFont.dubai,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(controller2.remoteState.reserveState.length, (index) {
                    return Container(
                      color: AppColors.grayColor,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 10),
                      padding:const EdgeInsets.all(0),
                      child: CustomText(
                        text:
                            controller2.remoteState.reserveState[index].reserveDate.toString().substring(0,20),
                        fontFamily: ArabicFont.avenirArabic,
                        fontSize: 17,
                        colorText: AppColors.secondary,
                      ),
                    );
                  }),
                ),
        ),
        isScrollControlled: true,
        elevation: 1.5,
        useRootNavigator: true,
        enterBottomSheetDuration: const Duration(milliseconds: 450),
        exitBottomSheetDuration: const Duration(milliseconds: 450),
        backgroundColor: AppColors.grayColor);
  }
}
