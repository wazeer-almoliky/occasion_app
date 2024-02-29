import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/service_price_controller.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_drop_down_search.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class ServicePrice extends StatelessWidget {
  const ServicePrice({super.key});

  @override
  Widget build(BuildContext context) {
    final outerterController = Get.find<ServicePriceController>();//"أسعــار الخدمــات"
    return Scaffold(
      appBar:  DAppBar(title: "أسعــار الخدمــات",back: AppColors.secondary,front: AppColors.primary,),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            ...List.generate(
                2,
                (index) => Obx(() {
                      if (outerterController.remoteState.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return CustomDropDownSearch(
                          items: outerterController.dropDownBoxData(index),
                          labelText:
                              index == 0 ? "اســم الخدمـة" : "نـوع الفترة",
                          hintText:
                              index == 0 ? "اســم الخدمـة" : "نـوع الفترة",
                          margin: const EdgeInsets.only(bottom: 25),
                          onChanged: (val) {
                            if (val != null) {
                              outerterController.valueOfDropBox[index] = val;
                            }
                          },
                        );
                      }
                    })),
            Form(
                key: outerterController.priceKey,
                child: InputField(
                  controller: outerterController.name,
                  label: "السعــر",
                  hint: "السعــر",
                  suffixIcon: const Icon(Icons.attach_money),
                  onValid: (val) {
                    return FormValidations.checkValidations(val!, 2, 20);
                  },
                )),
                 const SizedBox(
              height: 35,
            ),
            CustomButton(
              onPressed: () {
                outerterController.periodRequest();
              },
              text: "حفــــــظ",
              fontSize: 21,
              fontWeight: FontWeight.bold,
              textColor: AppColors.primary,
              buttonColor: AppColors.secondary,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            )
          ],
        ),
      ),
    );
  }
}
