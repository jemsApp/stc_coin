import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:math' as math;
import 'package:lottie/lottie.dart';
import 'package:stc_coin/pages/starting/login.dart';
import 'package:stc_coin/pages/starting/splash.dart';
import 'package:stc_coin/pages/starting/terms.dart';
import 'package:stc_coin/pages/subPage/support.dart';
import 'package:stc_coin/pages/subPage/videoPlayer.dart';
import 'package:stc_coin/pages/subPage/withdrowal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/buton.dart';
import 'package:stc_coin/server.dart';

class spinPage extends StatefulWidget {
  spinPage();

  @override
  State<spinPage> createState() => _spinPageState();
}

class _spinPageState extends State<spinPage>
    with SingleTickerProviderStateMixin {
  List<double> sectors = [5, 6, 10, 0, 50, 8, 1, 0];
  int randomSectorIndex = -1;
  List<double> sectorRediance = [];
  double angle = 0;
  bool isSpining = false;
  double earnedValue = 0;
  double totalEarnning = 0;
  int spiningDuration_ms = 2000; //3.6 sec
  math.Random random = math.Random();
  final _spinStat = Get.put(spinPageState());
  int totalSpin = 0;
  final GlobalKey<ScaffoldState> _homeScafold = new GlobalKey<ScaffoldState>();
  late AnimationController spin_Ac;
  late Animation<double> animation;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> user = [];
  bool preshed = false;
  int nextRandomIndexIs=0;

  //-----------------internet checking
  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateSectorsRediance();
    spin_Ac = AnimationController(
        vsync: this, duration: Duration(milliseconds: spiningDuration_ms));
    Tween<double> tween = Tween<double>(begin: 0, end: 1);
    CurvedAnimation curved =
        CurvedAnimation(parent: spin_Ac, curve: Curves.decelerate);
    animation = tween.animate(curved);

    //rebuild screen but animation countinue

    spin_Ac.addListener(() {
      if (spin_Ac.isCompleted) {
        setState(() {
          _recordState();
          isSpining = false;
        });
      }
    });
    _getConnectivity();
    _getUser();

  }

  _getConnectivity(){
    subscription=Connectivity().onConnectivityChanged.listen((event) async {
      isDeviceConnected=await InternetConnectionChecker().hasConnection;
      if(!isDeviceConnected && isAlertSet == false){
        showConnectionAlertBox();
        setState(() {
          isAlertSet=true;
        });
      }
    });
  }

  Future<bool>_onBackButtonPresses(BuildContext context)async{
    bool? exitApp=await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Are You Sure ??"),
        content: const Text("Do you want to Close this App"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: Text('No')),

          TextButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: Text('Yes')),

        ],
      );
    },);
    return exitApp??false;
  }
  showConnectionAlertBox(){
    return showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: const Text("No Connection"),
        content: const Text('Please Check Your Internet Connectivity'),
        actions: [
          TextButton(onPressed: () async {
            Navigator.pop(context,'Cansel');
            setState(() {
              isAlertSet=false;
            });
            isDeviceConnected=await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected){
              showConnectionAlertBox();
              setState(() {
                isAlertSet=true;
              });
            }

          }, child: Text('ok'))
        ],
      );
    },);
  }
  Future _getUserCoin() async {
    var data = await server.getuserCoin(num: user[0]).then((value) {
      _spinStat.userTotalCoin.value = double.parse(value['1']);
      _spinStat.totalSpin.value = int.parse(value['2']);
    });
    _addSpin();
  }

  Future _getUser() async {
    final SharedPreferences prefs = await _prefs;
    DateTime date = DateTime.now();
    user = prefs.getStringList("user")!;
    totalSpin = prefs.getInt("totalSpin") ?? 0;
    _getUserCoin();
  }

  Future _addSpin() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt("totalSpin", totalSpin);
    print(
        "Total Spin === ${totalSpin}  //  Main Spin  ==== ${_spinStat.totalSpin.value}");
    Dio dio = Dio();
    var res = await dio
        .get(
            "$SERVER/addCoin.php?num=${user[0]}&&coin=${_spinStat.userTotalCoin.value}&&spin=${_spinStat.totalSpin.value + _spinStat.bonusSpin.value}")
        .then((value) {
      _spinStat.bonusSpin.value = 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    spin_Ac.dispose();
    subscription.cancel();
  }

  _recordState() async {

    earnedValue = sectors[sectors.length - (randomSectorIndex + 2)];
    _spinStat.userTotalCoin.value = _spinStat.userTotalCoin.value + earnedValue;
    _addSpin();
  }

  _generateSectorsRediance() {
    // Radiuse For Single sector
    double one_sectorRediance = 2 * math.pi / (sectors.length - 1);

    for (int i = 0; i < sectors.length; i++) {
      sectorRediance.add((i + 1) * one_sectorRediance);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: WillPopScope(
        onWillPop: ()=>_onBackButtonPresses(context),
        child: Scaffold(
          key: _homeScafold,
          body: _body(_h, _w),
          drawer: _drawer(_h, _w),
        ),
      ),
    );
  }

  _drawer(_h, _w) {
    return FutureBuilder(
      future: _getUser(),
      builder: (context, snapshot) {
        return Drawer(
          width: _w * 0.67,
          backgroundColor: Colors.black,
          child: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    //  padding: EdgeInsets.all(100),
                    // margin: EdgeInsets.all(20),
                    height: _h * 0.16,
                    width: _w * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("asset/img/stcLogo.png"),
                            fit: BoxFit.fill)),
                  ),
                  Text(
                    "STC Coin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "f1",
                        fontSize: _h * 0.035,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: _h * 0.5,
                    width: _w * 1,
                    child: ListView(
                      children: [
                        ExpansionTile(
                          title: Text(
                            "Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.account_box_sharp,
                            color: Colors.white.withAlpha(100),
                          ),
                          children: [
                            Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "-",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Text("${user[2]}",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "E-Mail",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "-",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Text("${user[3]}",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Number",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "-",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Text("${user[0]}",
                                        style: TextStyle(color: Colors.white)))
                              ],
                            ),
                            Divider(
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Get.off(() => spinPage());
                          },
                          leading: Icon(
                            Icons.gamepad_outlined,
                            color: Colors.white.withAlpha(100),
                          ),
                          title: Text(
                            "Play Game",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => withdrowal(user));
                          },
                          leading: Icon(
                            Icons.monetization_on,
                            color: Colors.white.withAlpha(100),
                          ),
                          title: Text(
                            "Withdrawal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => support());
                          },
                          leading: Icon(
                            Icons.support_agent_outlined,
                            color: Colors.white.withAlpha(100),
                          ),
                          title: Text(
                            "Support",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => terms());
                          },
                          leading: Icon(
                            Icons.account_balance_rounded,
                            color: Colors.white.withAlpha(100),
                          ),
                          title: Text(
                            "Game T&C",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    alignment: Alignment.center,
                                    height: _h * 0.15,
                                    color: Colors.black,
                                    child: Text(
                                      "Are You Sure For LogOut Your Account ??",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "",
                                          fontSize: _h * 0.03,
                                          color: Colors.white),
                                    ),
                                  ),
                                  actions: [
                                    button(
                                      onTab: () async {
                                        _addLoginOfline();
                                      },
                                      width: _w * 0.8,
                                      height: _h * 0.06,
                                      text: "Yes",
                                      fontsize: _w * 0.08,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          leading: Icon(
                            Icons.logout,
                            color: Colors.white.withAlpha(100),
                          ),
                          title: Text(
                            "LogOut",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Powered By :",
                        style: TextStyle(
                            color: Colors.white.withAlpha(100),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                      Image(
                        color: Colors.white.withAlpha(100),
                        image: AssetImage("asset/img/sidhlogo.png"),
                        height: _h * 0.1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _appBar(double _h, double _w) {
    return Container(
      height: _h * 0.1,
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(100),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                _homeScafold.currentState!.openDrawer();
              },
              child: SizedBox(
                height: _h * 0.07,
                width: _w * 0.1,
                child: Icon(
                  Icons.dehaze_rounded,
                  size: 30,
                  color: Colors.red,
                ),
              )),
          Spacer(),
          TextButton(
              onPressed: () {},
              child: Text(
                "STC Coin",
                style: TextStyle(
                  fontFamily: "f1",
                  color: Colors.white,
                  fontSize: _h * 0.05,
                ),
              )),
          Spacer(),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            height: _h * 0.05,
            width: _w * 0.3,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: FutureBuilder(
              future: _getUserCoin(),
              builder: (context, snapshot) {
                return Obx(() => Text("${_spinStat.userTotalCoin.value}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: _h * 0.03)));
              },
            ),
          )
        ],
      ),
    );
  }

  _body(double _h, double _w) => Column(
        children: [
          Stack(
            children: [
/////////////////////////////////////////////////////   BackGround  //////////////////////////////////////////////////////////////////
              Container(
                height: _h * 0.95,
                width: _w,
                decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.lighten,
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("asset/img/background1.jpg"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: _h * 0.95,
                width: _w,
                color: Colors.white.withAlpha(100),
                child: _customSpiner(_h, _w),
              ),
/////////////////////////////////////////////////////   APPBAR //////////////////////////////////////////////////////////////////
              _appBar(_h, _w),
              SizedBox(
                height: _h * 0.95,
                child: Align(
                  child: SizedBox(
                    height: _h * 0.20,
                    child: Stack(children: [
                      //   Image.asset("asset/img/roulette-center-300.png"),
                      Image.asset("asset/img/stcLogo.png")
                    ]),
                  ),
                ),
              ),
/////////////////////////////////////////////////////   BOTOM  //////////////////////////////////////////////////////////////////

//               SizedBox(
//                 height: _h * 0.95,
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.all(10),
//                     height: _h * 0.05,
//                     width: _w * 0.3,
//                     decoration: BoxDecoration(
//                         color: Colors.yellow.withAlpha(200),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: FutureBuilder(future: _getUserCoin(),builder: (context, snapshot) {
//                       return Obx(() => Text("${_spinStat.totalSpin.value}",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: _h * 0.03)));
//                     },),
//                   ),
//                 ),
//               ),
              SizedBox(
                height: _h * 0.95,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      preshed = false;
                      if (!isSpining) {
                        setState(() {
                          isSpining = true;
                          _spinTheWheel(_h, _w);
                        });
                      }
                    },
                    child: SizedBox(
                      height: _h * 0.15,
                      child: Lottie.asset("asset/img/go.json",
                          animate: !isSpining),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: _h * 0.95,
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: InkWell(
              //       onTap: () {
              //        _adsShowDialog(context, _h, _w);
              //       },
              //       child: Container(
              //         alignment: Alignment.center,
              //         margin: EdgeInsets.all(10),
              //         height: _h * 0.05,
              //         width: _w * 0.3,
              //         decoration: BoxDecoration(
              //             color: Colors.green.withAlpha(160),
              //             borderRadius: BorderRadius.circular(10)),
              //         child:  Text("+1 Spin",
              //             style: TextStyle(
              //                 color: Colors.black,
              //                 fontFamily: "",
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: _h * 0.03)),
              //       )
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      );

  Widget _customSpiner(double _h, double _w) => Container(
        height: _h * 0.65,
        width: _w * 0.98,
        padding: EdgeInsets.only(top: _h * 0.025),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/img/belt.png"), fit: BoxFit.contain)),
        child: AnimatedBuilder(
          animation: spin_Ac,
          builder: (context, child) {
            return Transform.rotate(
              angle: spin_Ac.value * angle,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(_w * 0.07),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/img/spinner.png"))),
              ),
            );
          },
        ),
      );

  _adsShowDialog(BuildContext context, double _h, double _w) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(130),
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(_h * 0.01),
          title: Text(
            "Watch The Ads And Get Spin..!",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Container(
              alignment: Alignment.center,
              height: _h * 0.28,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: _h * 0.2,
                    width: _w * 0.8,
                    child: Image.asset("asset/img/ytads.png"),
                  ),
                  Text("+1",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: _h * 0.065,
                          fontWeight: FontWeight.bold))
                ],
              )),
          contentPadding: EdgeInsets.all(_h * 0.01),
          actionsPadding: EdgeInsets.all(_h * 0.01),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button(
                  onTab: () {
                    if (!preshed) {
                      if (!preshed) {
                        preshed = true;
                        _spinStat.totalSpin.value =
                            _spinStat.totalSpin.value + 1;
                        totalSpin++;
                      }

                      _addSpin().then((value) {
                        _getUserCoin();
                        setState(() {
                          isSpining = false;
                          Navigator.pop(context);
                          Get.to(() => VideoApp());
                        });
                      });
                    }
                  },
                  width: _w * 0.36,
                  height: _h * 0.045,
                  text: "Get It",
                  fontsize: _w * 0.08,
                  font: "",
                ),
                button(
                  onTab: () async {
                    Navigator.pop(context);
                  },
                  width: _w * 0.36,
                  height: _h * 0.045,
                  text: "Cancle",
                  fontsize: _w * 0.08,
                  font: "",
                )
              ],
            )
          ],
        );
      },
    );
  }

  void _spinTheWheel(_h, _w) {

    if (_spinStat.totalSpin.value > 0) {
      double randomRedian;

      do {
        randomSectorIndex = random.nextInt(sectors.length - 2);
        randomRedian = _generateRandomRadian();
        nextRandomIndexIs = sectors.length - (randomSectorIndex + 2);
      } while ((nextRandomIndexIs == 4 && totalSpin < 100) ||
          (nextRandomIndexIs == 2 && totalSpin < 90) ||
          (nextRandomIndexIs == 5 && totalSpin < 90)
        );

      if (nextRandomIndexIs == 2) {
        totalSpin = totalSpin - 50;
      } else if (nextRandomIndexIs == 4) {
        totalSpin = totalSpin - 100;
      }

      spin_Ac.reset();
      angle = randomRedian;
      spin_Ac.forward().then((value) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            content: SizedBox(
                height: _h * 0.24,
                width: _w * 0.4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image:AssetImage("asset/img/background1.jpg"),fit: BoxFit.cover,opacity: 0.3)
                  ),
                  child: Column(
                    children: [
                      Text("You Won",style: TextStyle(fontFamily: "f1",color: Colors.black,fontWeight: FontWeight.bold,fontSize: _h*0.07),),
                      Container(
                          alignment: Alignment.center,
                          height: _h*0.14,
                          width: _w*0.25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(colors: [
                                Color(0xFFEA7575),
                                Color(0xFFAF3131),
                                Color(0xFF5B2323),

                              ])
                          ),
                          child: Text("${sectors[nextRandomIndexIs]}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "",fontWeight: FontWeight.bold,fontSize: _h*0.055),)),
                    ],
                  ),
                )
            ),
          );
        },
      ));
      _spinStat.totalSpin.value--;
      _addSpin();

    }
    else
    {
      _adsShowDialog(context, _h, _w);
      setState(() {
        isSpining = false;
      });
    }
  }

  double _generateRandomRadian() {
    return (2 * math.pi * sectors.length) + sectorRediance[randomSectorIndex];
  }

  Future<void> _addLoginOfline() async {
    final SharedPreferences prefs = await _prefs;
    // final List<String>? user = prefs.getStringList("user")??[];
    prefs.setStringList('user',[]).then((value) => Get.to(() => splash()));
  }
}

class spinPageState extends GetxController {
  RxDouble userTotalCoin = 0.0.obs;
  RxInt totalSpin = 0.obs;
  RxInt bonusSpin = 0.obs;
}
