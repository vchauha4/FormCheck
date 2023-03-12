import 'dart:io';
import 'package:gym_app/FeedBack.dart';
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'Camera.dart';
import 'appbarclipper.dart';

class InfoPageDetail extends StatefulWidget {
  const InfoPageDetail({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  State<InfoPageDetail> createState() => _InfoPageDetailState();
}

class _InfoPageDetailState extends State<InfoPageDetail> {

  bool shadowColor = false;
  double? scrolledUnderElevation;
  @override
  Widget build(BuildContext context) {
    // initPlayerPermission();

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    // return
    //     Stack(
    //         clipBehavior: Clip.none,
    //         children: <Widget>[
    //           ClipPath(
    //             clipper: AppBarClipper(),
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: Colors.blue[900],
    //               ),
    //               height: MediaQuery.of(context).size.height * 0.21,
    //             ),
    //           ),
    //
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 28),
    //             child: SizedBox(
    //               child: Center(
    //                 child:
    //                   Text(
    //                       'BenchPress ',
    //                       textAlign: TextAlign.center,style: TextStyle(fontSize: 45,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'))
    //                   ,
    //
    //
    //
    //               ),
    //               height: 60,
    //             ),
    //           ),
    //         ]
    //     );

    List text=['Bench Press      ','Squats      ','Curl        ',];
    List text2=['Bench Press','Squats','Curl2',];


    return Scaffold(
      // appBar: AppBar(title: const Text('BenchPress'),
      //   scrolledUnderElevation: scrolledUnderElevation,
      //   shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      // ),


        backgroundColor: const Color(0xFF212224),

        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Center(child:Text(text[widget.number],  textAlign: TextAlign.justify,style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),)),
                backgroundColor: Color(0xFF111213),
                pinned: true,
                floating: true,
                elevation: 20,
                centerTitle: true,
                expandedHeight: 80.0,
                collapsedHeight: 75,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                shadowColor:Colors.red,
                toolbarHeight: 70,



              ),

            ];
          },
          body: Container(
            height: mediaQueryData.size.height,
            width: mediaQueryData.size.width,
            decoration:  BoxDecoration(
                image: DecorationImage(image: AssetImage('Assets/cyber9.jpeg')//FileImage(File('/storage/emulated/0/AudioFiles/itachi.jpg'))
                    , fit: BoxFit.cover, opacity: 0.1),//HERE IS backgroundColor

                gradient: LinearGradient(
                    colors: [Color(0xFF616161), Color(0xFF212121)],
                    stops: [0.05, 0.62],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.repeated)),

            child: Column(
              children: [
                SizedBox(height: 7,),

                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text(
                        'Below we provide information that explains',
                        style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text(
                      'how to properly perform '+text2[widget.number]+':',
                      style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),

                  ],
                ),
                // Row(
                //   children: [
                //     SizedBox(width: 15,),
                //     Text(
                //         'Bench press:',
                //         style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.start
                //     ),
                //   ],
                // ),

                SizedBox(height: 30,),

                BenchInfo(),

                SizedBox(height: 20,),






              ],
            ),

          ),



        )
    );

  }

  BenchInfo(){

    return   Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/BenchPress4.gif'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                fit: BoxFit.cover,

              ),
              borderRadius:  BorderRadius.all(Radius.circular(15.0)),
            ),
            alignment: Alignment.center,
            width: 150,
            height: 150,
          ),
        ),
      ],
    );

  }












}
