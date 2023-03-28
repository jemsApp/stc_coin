import 'dart:convert';

import 'package:dio/dio.dart';

const String SERVER="https://stc.pubfire.net";
class server{

  static Future newUserSignUp({String name="",String num="",String email="",String age="",String city="",String adhar="",String pass=""})async{
    Dio dio=Dio();
    FormData formData=FormData.fromMap({
      'name':name,
      'number':num,
      'email':email,
      'age':age,
      'city':city,
      'adharNum':adhar,
      'pass':pass
    });
    var  res =await dio.post("$SERVER/signUp.php",data: formData);

    if(res.statusCode==200) return true; else return false;

  }


  static Future userLogin({String num="",String pass=""})async{
    Dio dio=Dio();

    Map? data;
    String dataString;
    var res =await dio.get("$SERVER/checkLogIn.php?number=$num&&pass=$pass").then((value) {
      print(value);
      return value;
      // dataString=value.data.toString();
     //   dataString==null?data={}:data=jsonDecode(dataString);

    });
  }

  static Future getuserCoin({String num=""})async{
    Dio dio=Dio();

    Map? data;
    String dataString="";
    var res =await dio.get("$SERVER/getCoin.php?number=$num").then((value) {
        dataString=value.data;
      dataString=value.data.toString();
       data=jsonDecode(dataString);
    });
    // await Future.delayed(Duration(seconds: 1));
    return data;
  }

  static Future paymentRequest({String name="",String bank="",String accNum="",String mobile="",String adhar="",String ifsc="",String coin=""})async{
    Dio dio=Dio();
    FormData formData=FormData.fromMap({
      'name':name,
      'bank':bank,
      'accNum':accNum,
      'mobile':mobile,
      'ifsc':ifsc,
      'adhar':adhar,
      'coin':coin
    });
    var  res =await dio.post("$SERVER/payment.php",data: formData);

    if(res.statusCode==200) return true; else return false;

  }

}