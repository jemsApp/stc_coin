

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stc_coin/pages/spinPage.dart';
import 'package:stc_coin/pages/starting/choose.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:stc_coin/server.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/buton.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  final _spinState=Get.put(spinPageState());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String newVersionDownloadUrl="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wait_redirect();
  }

  Future<bool>_isUpdateAvailable() async {
    Dio dio=Dio();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String updatedVersion=await dio.get("$SERVER/getNewVersion.php").then((res) { String data=res.data.toString();
    List<String>data2=data.split("~");
    newVersionDownloadUrl=data2[1];
    print(data2);
    return data2[0];
    });
    return (currentVersion==updatedVersion);
  }
  Future _getBounusSpin()async{
     int bonusSpin=0;
    final SharedPreferences prefs = await _prefs;
    DateTime date=DateTime.now();
    // print("======${date}");
    String pastDateString=prefs.getString("lastDay")??"null";

    if(pastDateString=="null")
      {
        prefs.setString('lastDay', date.toString());
      }
    else {
      DateTime lastSeen = DateTime.tryParse(pastDateString)!;
      int differnt = date
          .difference(lastSeen)
          .inDays;
      print("===${differnt}");
      if(differnt>=1)
        {
          _spinState.bonusSpin.value=3;
          prefs.setString('lastDay', date.toString());
        }
    }
  }
  wait_redirect()async{
    await _getBounusSpin();
    final SharedPreferences prefs = await _prefs;
    final List<String>? user = prefs.getStringList("user")??[];
    print(user!.length==0);

   if(await _isUpdateAvailable()){
    await Future.delayed(Duration(seconds: 2)).then((value) => Get.off(()=>user.length==0?choose():spinPage()));
   }
   else
     {
        double _h=MediaQuery.of(context).size.height;
        double _w=MediaQuery.of(context).size.width;
        _showUpdateDialog(_h, _w);
     }
  }

  _showUpdateDialog(_h,_w)=>showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          alignment: Alignment.center,
          height: _h * 0.15,
          color: Colors.black,
          child: Text(
            "New Updated STC Coin Version Available Update First",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "",
                fontSize: _h * 0.03,
                color: Colors.white),
          ),
        ),
        actions: [
          button(
            onTab: () {
              _launchDownloadUrl();
            },
            width: _w * 0.8,
            height: _h * 0.06,
            text: "Update Now",
            fontsize: _w * 0.08,
          )
        ],
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    double _h=MediaQuery.of(context).size.height;
    double _w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _h,
        width: _w,
        decoration: BoxDecoration(backgroundBlendMode: BlendMode.lighten,
        color: Colors.white,
        image: DecorationImage(image: AssetImage("asset/img/redbackground.jpg"),fit: BoxFit.cover)
        ),
        child: Center(
          child: Image(image: AssetImage("asset/img/stcLogo.png")),
        ),
      ),
    );
  }
  Future<void> _launchDownloadUrl() async {
    if (!await launch(newVersionDownloadUrl)) {
      throw Exception('Could not launch $newVersionDownloadUrl');
    }
  }
}
