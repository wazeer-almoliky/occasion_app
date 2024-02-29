import 'dart:developer';
import 'dart:io';
import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:occasion_app/controller/services_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_drop_down_search.dart';
import 'package:occasion_app/utilities/classes/custom_icon_button.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});
  @override
  Widget build(BuildContext context) {
    final outerterController = Get.put(ServicesController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
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
              text: "إضــافة خدمـــة",
              fontFamily: ArabicFont.tajawal,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              colorText: AppColors.primary,
            )),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.only(top: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          children: [
            Form(
                key: outerterController.servicesKey,
                child: Column(
                  children: [
                    if (outerterController.admin == "عادي")
                      Obx((){
                        if(outerterController.remoteState.isLoading.value){
                          return const Center(child: CircularProgressIndicator(),);
                        }else{
                          return CustomDropDownSearch(
                          items: outerterController.listOfDataService(),
                          // labelText: "نــوع الخدمـة",
                          hintText: "نــوع الخدمـة",
                          margin: const EdgeInsets.only(bottom: 15),
                          onChanged: (val) {
                            if (val != null) {
                              outerterController.valueOfDropDownBox(val);
                              outerterController.update();
                            }
                          },
                        );
                        }
                      }),
                    ...List.generate(
                        InputFieldData.serviceScreen.length,
                        (index) => InputField(
                              controller:
                                  outerterController.listOfController(index),
                              label: InputFieldData.serviceScreen[index].label,
                              hint: InputFieldData.serviceScreen[index].label,
                              suffixIcon: Icon(
                                  InputFieldData.serviceScreen[index].icon),
                              isNumber: false,
                              onValid: (val) {
                                return FormValidations.checkValidations(
                                    val!,
                                    InputFieldData.serviceScreen[index].min!,
                                    InputFieldData.serviceScreen[index].max!);
                              },
                            ))
                  ],
                )),
            const SizedBox(
              height: 18,
            ),
            //if (outerterController.admin == "عادي")
               CustomText(
                text: "إضـافـة صور",
                fontFamily: ArabicFont.tajawal,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                colorText: AppColors.primary,
                alignment: Alignment.center,
              ),
            const SizedBox(
              height: 13,
            ),
         //   if (outerterController.admin == "عادي")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    2,
                    (index) => CustomIconButton(
                          onPressed: () async {
                            if (index == 0) {
                              await outerterController.getImageCamera();
                            } else {
                              await outerterController
                                  .getImage(ImageSource.gallery);
                            }
                          },
                          icon: index == 0 ? Icons.camera_alt : Icons.image,
                          color: AppColors.secondary,
                          size: 70,
                        )),
              ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
              onPressed: () async {
                 log("||${outerterController.productID1}||");
                if(outerterController.productID1==0){
                  if(outerterController.photoID==0){
                    outerterController.request();
                  }else{
                   outerterController.addImage();
                  }
                }
                else{
                  log("1");
                //  outerterController.updateRequest();
                }
                
              },
              text:outerterController.productID1==0? "إضـافــــة":"نعـديـــل",
              fontFamily: ArabicFont.dinNextLTArabic,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondary,
              buttonColor: AppColors.primary,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
            ),
            const SizedBox(
              height: 13,
            ),
           // if (outerterController.admin == "عادي")
              GetBuilder<ServicesController>(
                  init: ServicesController(),
                  builder: (innerController) {
                    return GridView.count(
                      crossAxisCount: 1,
                      // mainAxisSpacing: 10,
                      // crossAxisSpacing: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: innerController.mediaFileList.isNotEmpty
                          ? List.generate(innerController.mediaFileList.length,
                              (index) {
                              return Container(
                                // color: AppColors.grayColor,
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: (Get.width / 2) - 10,
                                  height: (Get.width / 2) - 10,
                                  padding: const EdgeInsets.all(8.0),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: AppColors.grayColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppColors.grayColor,
                                          width: 1.9,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside)),
                                  child: Image.file(
                                    File(
                                      innerController.mediaFileList[index].path,
                                    ),
                                    width: (Get.width / 2) - 20,
                                    height: (Get.width / 2) - 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            })
                          : [
                               Center(
                                child: CustomText(
                                  text: "",
                                  fontFamily: ArabicFont.avenirArabic,
                                  alignment: Alignment.center,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  colorText: AppColors.primary,
                                ),
                              )
                            ],
                    );
                  })
          ],
        ),
      ),
    );
  }
}
