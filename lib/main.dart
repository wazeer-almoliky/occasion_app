import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:occasion_app/controller/stting_controller.dart';
import 'package:occasion_app/utilities/constants/app_colors.dart';
import 'package:occasion_app/utilities/functions/api_function.dart';
import 'package:occasion_app/utilities/services/app_services.dart';
import 'package:occasion_app/view/screens/splash_screen.dart';
void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([AppService.mainInit()]);
  Get.put(SettingController(),permanent: true);
  Get.lazyPut(()=>Crud(),fenix: true);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title:"متعهــد حفــلات",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar'), Locale('en')],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
          useMaterial3: true,
          fontFamily: ArabicFont.changa),
      locale: const Locale('ar', 'YE'),
      darkTheme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
