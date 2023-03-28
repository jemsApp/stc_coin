import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stc_coin/server.dart';
import '../../widgets/buton.dart';

class withdrowal extends StatefulWidget {
  List<String> user;

  withdrowal(this.user);


  @override
  State<withdrowal> createState() => _withdrowalState();
}

class _withdrowalState extends State<withdrowal> {

  TextEditingController name_Tc = TextEditingController();

  TextEditingController adhar_Tc = TextEditingController();

  TextEditingController bankName_Tc = TextEditingController();

  TextEditingController ifsc_Tc = TextEditingController();

  TextEditingController accNum_Tc = TextEditingController();

  TextEditingController stcCoin_Tc = TextEditingController();

  TextEditingController covert_Tc = TextEditingController();

  double userHasCoin = 0.0;

  int userHasSpin=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coinInit();
  }

  Future _coinInit() async {
    var data = await server.getuserCoin(num: widget.user[0]).then((value) {
      userHasCoin = double.parse(value['1']);
      stcCoin_Tc.text = value['1'];
      double userCoin=double.parse(value['1']);
      userHasSpin=int.parse(value['2']);
      covert_Tc.text =   (userCoin / 10).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Withdrawal",
            style: TextStyle(fontFamily: "f2", fontSize: _h * 0.04),
          ),
          centerTitle: true,
          backgroundColor: Colors.black),
      body: Stack(
        children: [
          Container(
            height: _h,
            width: _w,
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.lighten,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("asset/img/redbackground.jpg"),
                    fit: BoxFit.cover)),
            child: Center(
              child: Image(image: AssetImage("asset/img/stcLogo.png")),
            ),
          ),
          Container(
            height: _h,
            width: _w,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.lighten,
              color: Colors.white.withAlpha(150),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
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
                          fontFamily: "f1",
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
                              fontFamily: "f1", color: Colors.white70),
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
                ),
                SizedBox(
                  height: _h * 0.085,
                  child: Padding(
                    padding: EdgeInsets.all(_w * 0.03),
                    child: TextField(
                      controller: bankName_Tc,
                      //   keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: "f1",
                          fontSize: _w * 0.05,
                          color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          //enabled: false
                          fillColor: Colors.black38,
                          filled: true,
                          prefixIcon: Icon(
                            CupertinoIcons.app_badge_fill,
                            color: Colors.white70,
                          ),
                          labelText: "Bank Name",
                          labelStyle: TextStyle(
                              fontFamily: "f1", color: Colors.white70),
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
                ),
                SizedBox(
                  height: _h * 0.085,
                  child: Padding(
                    padding: EdgeInsets.all(_w * 0.03),
                    child: TextField(
                      controller: accNum_Tc,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: "f1",
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
                          labelText: "Account Num",
                          labelStyle: TextStyle(
                              fontFamily: "f1", color: Colors.white70),
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
                ),
                SizedBox(
                  height: _h * 0.085,
                  child: Padding(
                    padding: EdgeInsets.all(_w * 0.03),
                    child: TextField(
                      controller: ifsc_Tc,
                      //        keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: "f1",
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
                          labelText: "IFSC Code",
                          labelStyle: TextStyle(
                              fontFamily: "f1", color: Colors.white70),
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
                ),
                SizedBox(
                  height: _h * 0.085,
                  child: Padding(
                    padding: EdgeInsets.all(_w * 0.03),
                    child: TextField(
                      controller: adhar_Tc,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontFamily: "f1",
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
                              fontFamily: "f1", color: Colors.white70),
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
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  "Convertor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "f1",
                      fontSize: _h * 0.035,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  "Minimum Withdrawal Ammount = 500 Rs",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: _h * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: _h * 0.085,
                      width: _w * 0.4,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black.withAlpha(180),
                            borderRadius:
                                BorderRadius.all(Radius.circular(_w * 0.03))),
                        child: TextField(
                          controller: stcCoin_Tc,
                          textAlign: TextAlign.center,
                          onChanged: (txt) {
                            if (txt != "") {
                              covert_Tc.text = (int.parse(txt) / 10).toString();
                            } else {
                              covert_Tc.text = "";
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.white, fontSize: _h * 0.04),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "STC Coin ",
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: _h * 0.035)),
                        ),
                      ),
                    ),
                    Text("=",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: _w * 0.1,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: _h * 0.085,
                      width: _w * 0.4,
                      child: Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(_w * 0.03))),
                        child: TextField(
                          controller: covert_Tc,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: _h * 0.035),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Rs",
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: _h * 0.04)),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: _h * 0.06,
                        width: _w * 0.3,
                        child: InkWell(
                          onTap: () {
                            stcCoin_Tc.text = 100.toString();
                            covert_Tc.text =
                                (int.parse(stcCoin_Tc.text) / 10).toString();
                          },
                          child: Container(
                            margin: EdgeInsets.all(_w * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_w * 0.03))),
                            child: Text("100",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _w * 0.06,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _h * 0.06,
                        width: _w * 0.3,
                        child: InkWell(
                          onTap: () {
                            stcCoin_Tc.text = 200.toString();
                            covert_Tc.text =
                                (int.parse(stcCoin_Tc.text) / 10).toString();
                          },
                          child: Container(
                            margin: EdgeInsets.all(_w * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_w * 0.03))),
                            child: Text("200",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _w * 0.06,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _h * 0.06,
                        width: _w * 0.3,
                        child: InkWell(
                          onTap: () {
                            stcCoin_Tc.text = 500.toString();
                            covert_Tc.text =
                                (int.parse(stcCoin_Tc.text) / 10).toString();
                          },
                          child: Container(
                            margin: EdgeInsets.all(_w * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_w * 0.03))),
                            child: Text("500",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _w * 0.06,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _h * 0.06,
                        width: _w * 0.3,
                        child: InkWell(
                          onTap: () {
                            stcCoin_Tc.text = 1000.toString();
                            covert_Tc.text =
                                (int.parse(stcCoin_Tc.text) / 10).toString();
                          },
                          child: Container(
                            margin: EdgeInsets.all(_w * 0.02),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_w * 0.03))),
                            child: Text("1000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _w * 0.06,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _h * 0.03,
                ),
                button(
                  onTab: () {
                    if (double.parse(stcCoin_Tc.text) > 1000 &&
                        userHasCoin > 1000) {
                      if (name_Tc.text != "" &&
                          adhar_Tc.text != "" &&
                          accNum_Tc.text != "" &&
                          bankName_Tc.text != "" &&
                          stcCoin_Tc.text != "" &&
                          ifsc_Tc.text != "") {
                        _coinInit().then(
                          (value) => _addSpin().then(
                            (value) {
                              server
                                  .paymentRequest(
                                      name: name_Tc.text,
                                      adhar: adhar_Tc.text,
                                      accNum: accNum_Tc.text,
                                      bank: bankName_Tc.text,
                                      coin: stcCoin_Tc.text,
                                      ifsc: ifsc_Tc.text,
                                      mobile: widget.user[0])
                                  .then((value) {
                                name_Tc.text = "";
                                adhar_Tc.text = "";
                                accNum_Tc.text = "";
                                bankName_Tc.text = "";
                                stcCoin_Tc.text = "";
                                ifsc_Tc.text = "";
                                covert_Tc.text = "";
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        alignment: Alignment.center,
                                        height: _h * 0.15,
                                        color: Colors.black,
                                        child: Text(
                                          "Request Submited , You will Get Ammount Within 4-7 Bussiness Days",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "f2",
                                              fontSize: _h * 0.032,
                                              color: Colors.white),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(_h * 0.01),
                                      actions: [
                                        button(
                                          onTab: () async {
                                            Navigator.pop(context);
                                          },
                                          width: _w * 0.8,
                                          height: _h * 0.06,
                                          text: "OK Thanks",
                                          fontsize: _w * 0.08,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Fill All Detail")));
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              alignment: Alignment.center,
                              height: _h * 0.15,
                              color: Colors.black,
                              child: Text(
                                "Minumum Withdrawal Ammount Is 500 Rs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "f2",
                                    fontSize: _h * 0.04,
                                    color: Colors.white),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(_h * 0.01),
                            actions: [
                              button(
                                onTab: () async {
                                  Navigator.pop(context);
                                },
                                width: _w * 0.8,
                                height: _h * 0.06,
                                text: "OK",
                                fontsize: _w * 0.08,
                              )
                            ],
                          );
                        },
                      );
                    }
                    // Get.to(()=>terms());
                  },
                  width: _w * 0.6,
                  height: _h * 0.06,
                  text: "Request",
                  fontsize: _w * 0.08,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _addSpin() async {
    Dio dio = Dio();
    double leftCoin = userHasCoin - double.parse(stcCoin_Tc.text);
    var res = await dio
        .get("$SERVER/addCoin.php?num=${widget.user[0]}&&coin=$leftCoin&&spin$userHasSpin");
  }
}
