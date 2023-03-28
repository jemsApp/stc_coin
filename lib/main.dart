

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stc_coin/pages/spinPage.dart';
import 'package:stc_coin/pages/starting/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
main(){

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown ]);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: "STC Coin",
    home: splash(),
  ));


}



