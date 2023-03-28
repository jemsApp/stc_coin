import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import '../../widgets/buton.dart';



class support extends StatelessWidget {

  String phoneNumber='+916354255063';
  String email='jenishdesai999@gmail.com';
  String instagram='stc_coin_official';
  String facebookHandle='';

  @override
  Widget build(BuildContext context) {
    double _h=MediaQuery.of(context).size.height;
    double _w=MediaQuery.of(context).size.width;
    return Scaffold(
    
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("Support",style: TextStyle(fontFamily: "",fontSize: _h*0.04),),
          centerTitle: true,
          backgroundColor: Color(0xffaf3131)
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: _h*0.3,
                  width: _w*0.66,
                  decoration: BoxDecoration(backgroundBlendMode: BlendMode.lighten,
                    color: Colors.black,
                    //  image: DecorationImage(image: AssetImage("asset/img/redbackground.jpg"),fit: BoxFit.cover)
                  ),
                  child: Image(fit: BoxFit.fill,image: AssetImage("asset/img/stcLogo.png")),
                ),
              //
              //   Text(
              // "STC Coin",
              // style: TextStyle(
              //   fontFamily: '',
              //   fontSize:_h*0.06,
              //   color: Colors.white,
              //   fontWeight: FontWeight.bold,
              // ),),
                InkWell(
                  onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 8.0,
                            contentPadding: EdgeInsets.all(18.0),
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            content: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  InkWell(
                                    onTap: () => launch('sms:' + phoneNumber),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      child: Text('Message'),
                                    ),
                                  ),
                                  Divider(),
                                  InkWell(
                                    onTap: () => launch('https://wa.me/' + phoneNumber),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50.0,
                                      child: Text('WhatsApp'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                  },
                  child: Center(
                    child: Container(
                      height: _h*0.08,
                      width: _w*0.94,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                        gradient: LinearGradient(colors: [
                          Color(0xFFEA7575),
                          Color(0xFFAF3131),
                          Color(0xFF5B2323),

                        ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(flex: 2,child: Icon(Icons.send_to_mobile,size: _h*0.04,)),
                          Expanded(flex: 6,child: Text("Contact Or Sms",style: TextStyle(fontFamily: "",color: Colors.white,fontWeight: FontWeight.bold,fontSize: _h*0.033),)),
                        ],
                      ),
                    ),
                  ),
                ),
                _space(_h),
                InkWell(
                  onTap: (){
                    launch('mailto:' + email);
                  },
                  child: Container(
                    height: _h*0.08,
                    width: _w*0.94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                      gradient: LinearGradient(colors: [
                        Color(0xFFEA7575),
                        Color(0xFFAF3131),
                        Color(0xFF5B2323),

                      ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Expanded(flex: 2,child: Icon(Icons.attach_email,size: _h*0.04,)),
                       Expanded(flex: 6,child: Text("Email Us",style: TextStyle(fontFamily: "",color: Colors.white,fontWeight: FontWeight.bold,fontSize: _h*0.033),)),
                      ],
                    ),
                  ),
                ),
                _space(_h),
                InkWell(
                  onTap: (){
                    launch('https://instagram.com/' + instagram);
                  },
                  child: Container(
                    height: _h*0.08,
                    width: _w*0.94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                      gradient: LinearGradient(colors: [
                        Color(0xFFEA7575),
                        Color(0xFFAF3131),
                        Color(0xFF5B2323),

                      ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 2,child:Icon(Typicons.social_instagram,size: _h*0.04,)),
                        Expanded(flex: 6,child:Text("Instagram",style: TextStyle(fontFamily: "",color: Colors.white,fontWeight: FontWeight.bold,fontSize: _h*0.033),)),
                      ],
                    ),
                  ),
                ),
                _space(_h),
                InkWell(
                  onTap: (){
                    launch('https://www.facebook.com/' + facebookHandle);
                  },
                  child: Container(
                    height: _h*0.08,
                    width: _w*0.94,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(_w*0.04)),
                      gradient: LinearGradient(colors: [
                        Color(0xFFEA7575),
                        Color(0xFFAF3131),
                        Color(0xFF5B2323),

                      ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 2,child:Icon(Typicons.social_facebook,size: _h*0.04,),),
                        Expanded(flex: 6,child:Text("Facebook Handle",style: TextStyle(fontFamily: "",color: Colors.white,fontWeight: FontWeight.bold,fontSize: _h*0.033),),),
                      ],
                    ),
                  ),
                ),
                // ContactUs(
                //
                //   email: 'jenishdesai999@gmail.com',
                //   companyName: 'STC Coin',
                //   companyFont: "",
                //   phoneNumber: '+916354255063',
                //   dividerThickness: 2,
                //   tagLine: 'Sidheshwar Infotech',
                //   instagram: "https://www.instagram.com/indiasbestjewellery/?hl=en",
                //   facebookHandle: "https://www.facebook.com/AmoreComeFallInLove/",
                //   phoneNumberText: "Contact Or SMS",
                //
                //   textColor: Colors.white, cardColor:  Colors.black.withAlpha(100), companyColor: Colors.black, taglineColor: Colors.white,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
  _space(_h)=>SizedBox(height: _h*0.03,);
}
