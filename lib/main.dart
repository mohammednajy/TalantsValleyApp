import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/auth_controller.dart';
import 'package:tanlants_valley_application/data/controller/form_validation.dart';
import 'package:tanlants_valley_application/router/route_genarator.dart';
import 'package:tanlants_valley_application/router/router.dart';
import 'package:tanlants_valley_application/router/routes_name.dart';
import 'package:tanlants_valley_application/storage/sherd_perf.dart';
import 'package:tanlants_valley_application/utils/helper.dart';
import 'package:tanlants_valley_application/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:tanlants_valley_application/view/screens/home/bnb_pages/user_management_page/edit_user_screen.dart';

import 'data/controller/user_management_controller/user_details_controller.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProvider(
      create: (context) => FormValidation(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserDetailsController(),
    ),
  ], child: const TalantsValleyApp()));
}

class TalantsValleyApp extends StatelessWidget {
  const TalantsValleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          scaffoldMessengerKey: UtilsConfig.scaffoldKey,
          debugShowCheckedModeBanner: false,
          initialRoute: ScreenName.splashScreen,
          onGenerateRoute: onGenerateRoute,
          navigatorKey: AppRouter.navigationKey,
          // home: FilePickerDemo(),
          theme: lightTheme,
        ),
      ),
    );
  }
}
