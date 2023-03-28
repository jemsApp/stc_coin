import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stc_coin/pages/starting/terms.dart';
import 'package:stc_coin/widgets/buton.dart';
import 'package:stc_coin/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class signup extends StatelessWidget {
  TextEditingController number_Tc = TextEditingController();
  TextEditingController pass_Tc = TextEditingController();
  TextEditingController name_Tc = TextEditingController();
  TextEditingController email_Tc = TextEditingController();
  TextEditingController city_Tc = TextEditingController();
  TextEditingController age_Tc = TextEditingController();
  TextEditingController aadhar_Tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

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
                    //  height: _h * 0.7,
                    width: _w * 0.95,
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius:
                            BorderRadius.all(Radius.circular(_w * 0.05))),
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: _w * 0.14),
                        //   child: Text(
                        //     "Sign Up",
                        //     style: TextStyle(
                        //         fontFamily: "",
                        //         fontSize: _w * 0.12,
                        //         color: Colors.white),
                        //   ),
                        // ),
                        SizedBox(
                          height: _h * 0.02,
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: name_Tc,
                              //  keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.profile_circled,
                                    color: Colors.white70,
                                  ),
                                  labelText: "Full Name",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: number_Tc,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.phone,
                                    color: Colors.white70,
                                  ),
                                  labelText: "Mobile Number",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: email_Tc,
                              //   keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.mail,
                                    color: Colors.white70,
                                  ),
                                  labelText: "E-Mail",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: age_Tc,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.app_badge,
                                    color: Colors.white70,
                                  ),
                                  labelText: "Age",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: city_Tc,
                              //        keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.map_pin_ellipse,
                                    color: Colors.white70,
                                  ),
                                  labelText: "City",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.085,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: pass_Tc,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              obscureText: true,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white70,
                                  ),
                                  labelText: "PassWord",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 3),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _h * 0.11,
                          child: Padding(
                            padding: EdgeInsets.all(_w * 0.03),
                            child: TextField(
                              controller: aadhar_Tc,
                              keyboardType: TextInputType.number,
                              maxLength: 12,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: _w * 0.05,
                                  color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  //enabled: false
                                  fillColor: Colors.black38,
                                  filled: true,
                                  prefixIcon: Icon(
                                    CupertinoIcons.creditcard,
                                    color: Colors.white70,
                                  ),
                                  labelText: "Aadhar Card Number",
                                  labelStyle: TextStyle(
                                      fontFamily: "", color: Colors.white70),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft:
                                              Radius.circular(_w * 0.05),
                                          topRight:
                                              Radius.circular(_w * 0.05))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(_w * 0.05),
                                          bottomRight:
                                              Radius.circular(_w * 0.05)))),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: _h * 0.03,
                        // ),
                        button(
                          onTab: () async {
                            if (number_Tc.text != "" &&
                                pass_Tc.text != "" &&
                                name_Tc.text != "" &&
                                email_Tc.text != "" &&
                                city_Tc.text != "" &&
                                age_Tc.text != "" &&
                                aadhar_Tc.text != "") {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: _h * 0.2,
                                      width: _w * 0.4,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                              final SharedPreferences _prefs = await prefs;
                              _prefs.setInt('totalSpin',0);

                              await server
                                  .newUserSignUp(
                                      adhar: aadhar_Tc.text,
                                      age: age_Tc.text,
                                      city: city_Tc.text,
                                      email: email_Tc.text,
                                      name: name_Tc.text,
                                      num: number_Tc.text,
                                      pass: pass_Tc.text)
                                  .then((value) {
                                    Get.to(()=>
                                        login(
                                            number_Tc.text,
                                            pass_Tc.text,
                                            name_Tc.text,
                                            email_Tc.text,
                                            city_Tc.text,
                                            age_Tc.text,
                                            aadhar_Tc.text));
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please Enter Full Detail")));
                            }
                          },
                          width: _w * 0.6,
                          height: _h * 0.06,
                          text: "Sign UP",
                          fontsize: _w * 0.08,
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
