import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stc_coin/pages/starting/login.dart';
import 'package:stc_coin/pages/starting/signup.dart';

import '../../widgets/buton.dart';

class choose extends StatelessWidget {
  const choose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
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
            height: _h * 0.30,
            child: Image(image: AssetImage("asset/img/stcLogo.png")),
          ),
          Container(
            height: _h * 0.4,
            width: _w * 0.9,
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(Radius.circular(_w * 0.05))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(
                  font: "f2",
                    fontsize: _w * 0.1,
                    height: _h * 0.05,
                    width: _w * 0.8,
                    text: "Log In",
                    onTab: (){
                      Get.to(()=>login());
                    },
                ),
                SizedBox(
                  height: _h * 0.02,
                ),
                Text("OR",style: TextStyle(fontFamily: "f2",fontSize: _w * 0.08,color: Colors.white),),
                SizedBox(
                  height: _h * 0.02,
                ),
                button(
                  color: Color(0xff9b2929),
                  font: "f2",
                  fontsize: _w * 0.1,
                  height: _h * 0.05,
                  width: _w * 0.8,
                  text: "Create Account",
                  onTab: (){
                    Get.to(()=>signup());
                  },
                ),
              ],
            ),
          )
            ],
          ),
        ),
      ),
    ));
  }
}
