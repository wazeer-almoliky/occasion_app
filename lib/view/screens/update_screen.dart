import 'package:occasion_app/controller/update_user_controller.dart';
import 'package:occasion_app/model/static/input_field_model.dart';
import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_input_field.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/form_validations.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DAppBar(
        title: controller.label,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: ListView(
          children: [
            Form(
                key: controller.userKey,
                child: Column(
                  children:
                      List.generate(InputFieldData.userAdmin.length, (index) {
                    return InputField(
                      controller: controller.listOfController(index),
                      label: InputFieldData.userAdmin[index].label,
                      hint: InputFieldData.userAdmin[index].label,
                      isNumber: false,
                      isPassword: index>0,
                      onValid: (val) {
                        return FormValidations.checkValidations(
                            val!,
                            InputFieldData.userAdmin[index].min!,
                            InputFieldData.userAdmin[index].max!);
                      },
                    );
                  }),
                )),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () {
                // controller
                if(controller.label=="اضافة"){
                  controller.addUser();
                }else{
                  
                  controller.updateUser();
                }
                
              },
              text: controller.label,
              textColor: AppColors.secondary,
              buttonColor: AppColors.primary,
              margin:const EdgeInsets.symmetric(horizontal: 30),
              fontSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
            )
          ],
        ),
      ),
    );
  }
}
