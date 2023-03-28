import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stc_coin/pages/spinPage.dart';
import 'package:stc_coin/widgets/buton.dart';
import 'package:stc_coin/widgets/spin.dart';
import '';

class terms extends StatelessWidget {
  const terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    String discription="""
    Hdfn  JNNn fdsnf NOJ fdssf dsf fjndsjf  fd f ld ffkgfg fldssfl sslvnlsdfl  fjndsjdsddsdjfdsddsjbv   jnjdsvdf djfdsdfdsd fdsjfdsd fd fdsjs fds fds  fdsdf dsd fjds  fj dsd dsd fjds dsd  dsdv fdsd dsf dsfdsdifdsf dsdjf dsdfdsdis  fds dfdsdf dsf  dffdssf dsdf d dfdd ffdsdf dssfdsjf dsd fdsds kklfdsdfds,dffldsf Hdfn  JNNn fdsnf NOJ fdssf dsf fjndsjf  fd f ld ffkgfg fldssfl sslvnlsdfl  fjndsjdsddsdjfdsddsjbv   jnjdsvdf djfdsdfdsd fdsjfdsd fd fdsjs fds fds  fdsdf dsd fjds  fj dsd dsd fjds dsd  dsdv fdsd dsf dsfdsdifdsf dsdjf dsdfdsdis  fds dfdsdf dsf  dffdssf dsdf d dfdd ffdsdf dssfdsjf dsd fdsds kklfdsdfds,dffldsf Hdfn  JNNn fdsnf NOJ fdssf dsf fjndsjf  fd f ld ffkgfg fldssfl sslvnlsdfl  fjndsjdsddsdjfdsddsjbv   jnjdsvdf djfdsdfdsd fdsjfdsd fd fdsjs fds fds  fdsdf dsd fjds  fj dsd dsd fjds dsd  dsdv fdsd dsf dsfdsdifdsf dsdjf dsdfdsdis  fds dfdsdf dsf  dffdssf dsdf d dfdd ffdsdf dssfdsjf dsd fdsds kklfdsdfds,dffldsf""";
    return Scaffold(
        body: Container(
          height: _h,
          width: _w,
          decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.lighten,
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("asset/img/redbackground.jpg"),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: _h * 0.22,
                    child: Image(image: AssetImage("asset/img/stcLogo.png")),
                  ),
                  SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                          height: _h * 0.7,
                        width: _w * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius:
                            BorderRadius.all(Radius.circular(_w * 0.05))),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: _w * 0.14),
                              child: Text(
                                "Terms & Condition",
                                style: TextStyle(
                                    fontFamily: "f2",
                                    fontSize: _w * 0.1,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              height: _h*0.5,
                              color: Colors.black45,
                              margin: EdgeInsets.symmetric(vertical: _h*0.03,horizontal: _w*0.05),
                              padding: EdgeInsets.symmetric(vertical: _h*0.01,horizontal: _w*0.02),
                              child: SingleChildScrollView(
                                child: Text(discription,style: TextStyle(color:Color(
                                    0xfff6e8e8),fontFamily: "font",fontSize: _w*0.06),),),
                            ),
                            button(
                              onTab: (){
                                Get.offAll(()=>spinPage());
                              },
                              width: _w * 0.6,
                              height: _h * 0.06,
                              text: "Agree & Continue",
                              fontsize: _w*0.06,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
