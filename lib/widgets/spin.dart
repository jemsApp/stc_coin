// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
// import 'package:get/get.dart';
//
//
//
//
//
// class spin extends StatefulWidget {
//   const spin({Key? key}) : super(key: key);
//
//   @override
//   State<spin> createState() => _spinState();
// }
//
// class _spinState extends State<spin>  with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//   Animation<double>? _animation;
//   final _stc=Get.put(totalAddPoint());
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   StreamController<int> controller = StreamController<int>();
//   int win = 0;
//   StreamController _dividerController = StreamController<int>();
//   final _wheelNotifier = StreamController<double>();
//   int totalPoint=0;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _dividerController.close();
//     _wheelNotifier.close();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _dividerController=StreamController<int>(
//         onPause: (){
//           _stc.totalPoint.value=_stc.totalPoint.value+_stc.selectedVal.value;
//           print(_stc.totalPoint.value);
//         }
//     );
//   }
//   Widget build(BuildContext context) {
//
//     double _h = MediaQuery.of(context).size.height;
//     double _w = MediaQuery.of(context).size.width;
//
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         // drawer: Drawer(
//         //   child: Container(
//         //     height: double.infinity,
//         //     width: double.infinity,
//         //     color: Colors.red,
//         //     child: Column(
//         //       children: [
//         //         Row(mainAxisAlignment: MainAxisAlignment.end,
//         //           children: [
//         //             IconButton(onPressed: () {
//         //               Navigator.pop(context);
//         //             }, icon: Icon(Icons.close))
//         //           ],),
//         //         SizedBox(height: 50,),
//         //         InkWell(onTap: () {Navigator.pop(context);}, child: Text("GO TO GAME",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: () {
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //             return withdraw();
//         //           },));
//         //         }, child: Text("WITHDRAW",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: (){
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //             return suportteam();
//         //           },));
//         //         }, child: Text("SUPPORT",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: () {
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //             return coin();
//         //           },));
//         //         }, child: Text("MY COIN",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: () {
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //             return condition();
//         //           },));
//         //         }, child: Text("TERMS & CONDITON",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: () {
//         //           Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //             return profile();
//         //           },));
//         //         }, child: Text("PROFILE",style: TextStyle(color: Colors.white),)),
//         //         SizedBox(height: 10,),
//         //         InkWell(onTap: () {
//         //         }, child: Text("LOGOUT",style: TextStyle(color: Colors.white),)),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.fill, filterQuality: FilterQuality.high,image: AssetImage("asset/img/background1.jpg"))),
//           child: Column(children: [
//             Container(
//               height: _h*0.1,
//               decoration: BoxDecoration(
//                   color: Colors.white.withAlpha(100),
//                   borderRadius: BorderRadius.circular(10)),
//
//               child: Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         "STC COIN",
//                         style: TextStyle(
//                           fontFamily: "f2",
//                           color: Colors.black,
//                           decorationColor: Colors.red,
//                           fontSize:_h*0.05 ,
//                         ),
//                       )),
//                   Spacer(),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.all(10),
//                     height: _h*0.05,
//                     width: _w*0.3,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Text("${win}",style: TextStyle(color: Colors.black,fontFamily: "f2",fontSize: _h*0.04)),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 7,
//               child:Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SpinningWheel(
//                     Image.asset('asset/img/roulette-8-300.png'),
//                     width: 310,
//                     height: 310,
//                     initialSpinAngle: _generateRandomAngle(),
//                     spinResistance: 0.6,
//                     canInteractWhileSpinning: false,
//                     dividers: 8,
//                     onUpdate: _dividerController.add,
//                     onEnd:_dividerController.onPause,
//                     secondaryImage:
//                     Image.asset('asset/img/roulette-center-300.png'),
//                     secondaryImageHeight: 110,
//                     secondaryImageWidth: 110,
//                     shouldStartOrStop: _wheelNotifier.stream,
//                   ),
//                   SizedBox(height: 30),
//                   StreamBuilder(
//                     stream: _dividerController.stream,
//                     builder: (context, snapshot)
//
//                         {
//                           if(snapshot.connectionState==ConnectionState.active)
//                             {
//                               return RouletteScore(snapshot.data as int);
//                             }
//                           else{
//                             return SizedBox();
//                           }
//                         }
//
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         _wheelNotifier.sink.add(_generateRandomVelocity());
//                       },
//                       child: CircleAvatar(
//                         foregroundImage: AssetImage("asset/img/stcLogo.png"),
//                         maxRadius: _h*0.06,
//                         backgroundColor: Colors.black,
//                       ))
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           _scaffoldKey.currentState!.openDrawer();
//                         },
//                         child: Icon(
//                           Icons.dehaze_rounded,
//                           size: 30,
//                           color: Colors.red,
//                         ))
//                   ],
//                 ))
//           ]),
//         ),
//       ),
//     );
//   }
//   double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
//
//   double _generateRandomAngle() => Random().nextDouble() * pi * 2;
// }
// class RouletteScore extends StatelessWidget {
//   final int selected;
//   final _stc=Get.put(totalAddPoint());
//   final Map<int, String> labels = {
//     1: '1000',
//     2: '400',
//     3: '800',
//     4: '7000',
//     5: '5000',
//     6: '300',
//     7: '2000',
//     8: '100',
//   };
//
//   RouletteScore(this.selected);
//
//
//   @override
//   Widget build(BuildContext context) {
//     //_stc.totalPoint.value+=int.parse(labels[selected]!);
//     _stc.selectedVal.value=int.parse(labels[selected]!);
//     return Text('${labels[selected]}',
//         style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white, fontSize: 24.0));
//   }
// }
//
// class totalAddPoint extends GetxController{
//   RxInt totalPoint =0.obs;
//   RxInt selectedVal=0.obs;
// }