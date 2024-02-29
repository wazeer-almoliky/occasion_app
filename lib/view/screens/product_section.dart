import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/product_section_controller.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
  //  reload();
    final outerController = Get.put(ProductSectionController());
    return Scaffold(
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Obx(() {
                  if (outerController.remoteState.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return outerController.remoteState.servicesState.isEmpty
                        ? CustomText(
                            text: "لا يوجـــد بيانــات",
                            fontSize: 20,
                            colorContainer: AppColors.secondary,
                          )
                        : ListView.builder(
                          itemCount: outerController.remoteState.servicesState.length,
                          itemBuilder: (_, index) {
                            final data =
                                outerController.remoteState.servicesState;
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(151, 240, 240, 240),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                onTap: (){
                                  log("${data[index].id}>>${ data[index].name!}");
                                  outerController.detailsViewScreen(id: data[index].id,name: data[index].name!);
                                },
                                title: CustomText(text:data[index].name!,fontSize: 20,fontWeight: FontWeight.w900,),
                                trailing: Icon(Icons.arrow_circle_left,size: 40,color: AppColors.primary,),
                              ),
                            );
                          });
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
