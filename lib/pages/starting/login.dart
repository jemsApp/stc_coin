import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stc_coin/pages/starting/terms.dart';
import 'package:stc_coin/server.dart';
import 'package:stc_coin/widgets/buton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  String number = "";
  String pass = "";
  String name = "";
  String email = "";
  String city = "";
  String age = "";
  String adhar = "";

  login([this.number = "", this.pass = "",this.name="",this.email="",this.city="",this.age="",this.adhar=""]);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController number_Tc = TextEditingController();

  TextEditingController pass_Tc = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number_Tc.text = widget.number;
    pass_Tc.text = widget.pass;
  }

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
                height: _h * 0.25,
                child: Image(image: AssetImage("asset/img/stcLogo.png")),
              ),
              Container(
                height: _h * 0.53,
                width: _w * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(_w * 0.05))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _w * 0.14),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontFamily: "f2",
                            fontSize: _w * 0.12,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: _h * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.all(_w * 0.03),
                      child: TextField(
                        controller: number_Tc,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontFamily: "",
                            fontSize: _w * 0.07,
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(_w * 0.05),
                                    topRight: Radius.circular(_w * 0.05))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_w * 0.05),
                                    bottomRight: Radius.circular(_w * 0.05))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_w * 0.05),
                                    bottomRight: Radius.circular(_w * 0.05)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_w * 0.03),
                      child: TextField(
                        controller: pass_Tc,
                        style: TextStyle(
                            fontFamily: "",
                            fontSize: _w * 0.07,
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(_w * 0.05),
                                    topRight: Radius.circular(_w * 0.05))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_w * 0.05),
                                    bottomRight: Radius.circular(_w * 0.05))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(_w * 0.05),
                                    bottomRight: Radius.circular(_w * 0.05)))),
                      ),
                    ),
                    SizedBox(
                      height: _h * 0.03,
                    ),
                    button(
                      onTab: () async {
                        Dio dio = Dio();
                        Map? data;
                        String dataString;
                        var res = await dio
                            .get(
                                "$SERVER/checkLogIn.php?number=${number_Tc.text}&&pass=${pass_Tc.text}")
                            .then((value) async {

                          dataString = value.data.toString();
                           dataString==null?data={}:data=jsonDecode(dataString);
                          if (data != null) {
                          //  print(data);

                            if(data!['number']==number_Tc.text&&data!['pass']==pass_Tc.text)
                              {

                                final SharedPreferences prefs = await _prefs;
                                final List<String> user =[
                                  data!['number'],
                                  data!['pass'],
                                  data!['name'],
                                  data!['email'],
                                  data!['city'],
                                  data!['age'],
                                  data!['adharNum']
                                ];
                                await prefs.setStringList('user', user);
                                print(user);
                                Get.to(() => terms());
                              }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "User Not Exist , Create New Account")));
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "User Not Exist , Create New Account")));
                          }
                        });
                      },
                      width: _w * 0.6,
                      height: _h * 0.05,
                      text: "Let's Go",
                    )
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
