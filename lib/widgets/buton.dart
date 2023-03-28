import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button extends StatelessWidget {

  double height=50,width=400,fontsize;
  Color color;

  var onTab;
  String text,font;
   button({this.height=50,this.width=300,this.color=const Color(0xff9b2929) ,this.text="exe",this.font="f1",this.fontsize=20,required this.onTab});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTab, child: Text(text,style: TextStyle(fontFamily: font,fontSize: fontsize),),
      style: ElevatedButton.styleFrom(primary: color,minimumSize: Size(width, height)),
    );
  }
}
