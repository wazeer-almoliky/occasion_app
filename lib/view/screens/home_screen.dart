import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:occasion_app/app_links.dart';
import 'package:occasion_app/controller/home_controller.dart';
// import 'package:occasion_app/utilities/classes/custom_buttom.dart';
import 'package:occasion_app/utilities/classes/custom_text.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/view/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<HomeController>();
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: "الرئيسية",
        front: AppColors.primary,
        back: AppColors.secondary,
        height: 200,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Obx(() {
          if (outerController.remoteState.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return outerController.remoteState.serviceState.isEmpty
                ? CustomText(
                    text: "لا يوجـــد بيانــات",
                    fontSize: 20,
                    colorContainer: AppColors.secondary,
                    alignment: Alignment.center,
                  )
                : Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: 250,
                          // color: Colors.grey,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                reverse: true,
                                height: 250.0,
                                autoPlay: true,
                                autoPlayCurve: Curves.easeIn,
                                autoPlayInterval:
                                    const Duration(milliseconds: 3500),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 1000),
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.zoom),
                            items: outerController.remoteState.serviceState
                                .map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${AppLinks.upload}/${i.url}"))),
                                  );
                                },
                              );
                            }).toList(),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Expanded(
                          child: AnimationLimiter(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 12,
                          childAspectRatio: (itemWidth / itemHeight),
                          controller: ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          children: List.generate(
                            outerController.remoteState.serviceState.length,
                            (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: InkWell(
                                      onTap: () {
                                        outerController
                                            .sectionServiceViewScreen(
                                                id: outerController.remoteState
                                                    .serviceState[index].id,
                                                name: outerController
                                                    .remoteState
                                                    .serviceState[index]
                                                    .name,
                                                index: index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          // padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              // color: const Color.fromARGB(
                                              //     255, 206, 205, 205),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "${AppLinks.upload}/${outerController.remoteState.serviceState[index].url}"))
                                                      ),
                                          child: SizedBox(
                                            // color: AppColors.primary,

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                // AspectRatio(
                                                //   aspectRatio: 3 / 3,
                                                //   child: Image.network(
                                                //       "${AppLinks.upload}/${outerController.remoteState.serviceState[index].url}",fit: BoxFit.cover,),
                                                // ),
                                                // const Spacer(),
                                                Container(
                                                  color: AppColors.blackColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  alignment: Alignment.center,
                                                  child: CustomText(
                                                    text: outerController
                                                        .remoteState
                                                        .serviceState[index]
                                                        .name!,
                                                    colorContainer:
                                                        AppColors.primary,
                                                    width: double.infinity,
                                                    alignment: Alignment.center,
                                                    colorText:
                                                        AppColors.whiteColor,
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                    ],
                  );
          }
        }),
      ),
    );
  }
}
/*

ListView.builder(
                      itemCount:
                          outerController.remoteState.serviceState.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: CustomButton(
                                onPressed: () {
                                  outerController.sectionServiceViewScreen(
                                      id: outerController
                                          .remoteState.serviceState[index].id,
                                      name: outerController
                                          .remoteState.serviceState[index].name,
                                      index: index);
                                },
                                text: outerController
                                    .remoteState.serviceState[index].name,
                                fontSize: 20,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 9),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                buttonColor: AppColors.whiteColor,
                                textColor: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

*/