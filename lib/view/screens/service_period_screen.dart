import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/services_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_icon_button.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';

class ServicePeriod extends StatelessWidget {
  const ServicePeriod({super.key});
  @override
  Widget build(BuildContext context) {
    final outerterController = Get.find<ServicesController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.secondary,
        // elevation: 0.0,
        toolbarHeight: 100,
        flexibleSpace: ClipPath(
          clipper: PointsClipper(),
          child: Container(
              height: 120,
              width: Get.width,
              color: AppColors.primary,
              child: Center(
                  child: CustomText(
                text: "فتــرات الخدمــات",
                fontFamily: ArabicFont.tajawal,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                colorText: AppColors.secondary,
              ))),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 25),
        children: [
          Form(
              key: outerterController.servicesKey, //InputFieldData
              child: Column(
                children: List.generate(
                    InputFieldData.servicePeriod.length,
                    (index) => InputField(
                          controller:
                              outerterController.listOfController(index),
                          label: InputFieldData.servicePeriod[index].label,
                          hint: InputFieldData.servicePeriod[index].label,
                          suffixIcon:
                              Icon(InputFieldData.servicePeriod[index].icon),
                          isNumber: false,
                          onValid: (val) {
                            return FormValidations.checkValidations(
                                val!, 0, 50);
                          },
                        )),
              )),
          const SizedBox(
            height: 35,
          ),
          CustomButton(
            onPressed: () {
              if(outerterController.title !=null){

              }else{
              outerterController.periodRequest();
              }
            },
            text: outerterController.title??"حفــــــظ",
            fontSize: 21,
            fontWeight: FontWeight.bold,
            textColor: AppColors.primary,
            buttonColor: AppColors.secondary,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          // ListView.builder(
          //   itemCount: outerterController.remoteState.periodState.length,
          //   itemBuilder: (_,index){
          //     return ;
          // }),
          Obx(() {
            if (outerterController.remoteState.periodState.isEmpty) {
              return Container();
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      outerterController.remoteState.periodState.length,
                  itemBuilder: (_, index) {
                    final data = outerterController.remoteState.periodState;
                    return ListTile(
                      title: CustomText(text: data[index].name!),
                      trailing: CustomIconButton(
                          onPressed: () {
                            outerterController.edit(data[index].name!,data[index].id!);
                          },
                          icon: Icons.edit_outlined),
                    );
                  });
            }
          })
        ],
      ),
    );
  }
}
