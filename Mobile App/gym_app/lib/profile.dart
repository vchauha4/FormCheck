import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'Boxes.dart';
import 'HomePage.dart';
import 'my_icons_icons.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final myBox= Boxes.getData();



  @override
  Widget build(BuildContext context) {
    final myData= myBox.get('user');
    int? benchCount=myData?.BenchCount;
    int? squatCount=myData?.SquatsCount;
    int? deadLiftCount=myData?.DeadliftCount;

    double? benchScore=myData?.BenchScore;
    double? squatScore=myData?.SquatsScore;
    double? deadLiftScore=myData?.DeadliftScore;

    // int benchCount=22;
    // int squatCount=45;
    // int deadLiftCount=2;
    //
    // double benchScore=59;
    // double squatScore=17;
    // double deadLiftScore=145;

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,

        // appBar: AppBar(
        //     title: Text('Clean',textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)),
        body: Container(
          height: mediaQueryData.size.height,
          width: mediaQueryData.size.width,
          decoration: BoxDecoration(

              //image: DecorationImage(image: FileImage(File('/storage/emulated/0/files/pictures/itachi.jpg')), fit: BoxFit.cover, opacity: 0.1),//HERE IS backgroundColor

              gradient: LinearGradient(
                  colors: [Color(0xFF616161), Color(0xFF212121)],
                  stops: [0.05, 0.62],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.repeated)),
          child: Column(children: [
            SizedBox(
              height: 5,
            ),


            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(
                            File('/storage/emulated/0/AudioFiles/itachi.jpg')),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    alignment: Alignment.center,
                    width: width,
                    height: height*.65,
                  ),
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      iconSize: 32,
                      icon: Icon(Icons.close),
                      color: Color(0xFF212121),
                      //632

                      alignment: Alignment.topLeft,

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(), //CameraPage(number: widget.number,),// make list take a parameter for the folder
                          ),
                        );
                        print("Clicked ");

                        //previous();
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: height*.59,),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                      child: Text("Itachi Uchiha",
                        style: TextStyle(fontSize: 34,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,),
                    ),
                  ],
                )

              ],

            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total Stats:",
                    style: TextStyle(fontSize: 24,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,),
                ],
              ),
            ),

            Row(
              children: [
                Card(
                  color: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 15,
                  child:InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 190,
                      height: 165,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 5, 0,5),
                                child: Text('Total Recordings:',
                                  style: TextStyle(fontSize: 22,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),


                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0,5),
                            child: Text((benchCount!+deadLiftCount!+squatCount!).toString(),
                              style: TextStyle(fontSize: 36,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Bench Press: '+benchCount.toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Squats: '+deadLiftCount.toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Curl: '+squatCount.toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),


                  // Column(
                  //   children: [
                  //   const SizedBox(
                  //   width: 160,
                  //   height: 110,
                  //   child: Text("Total Recordings:")
                  //   ),
                  //
                  //   ],
                  // ),

                ),




                Card(
                  color: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 15,
                  child:InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 186.5,
                      height: 165,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 0,5),
                                child: Text('Average Score:',
                                  style: TextStyle(fontSize: 22,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),


                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0,5),
                            child: Text((((benchScore!+deadLiftScore!+squatScore!)/3).toStringAsPrecision(3)).toString(),
                              style: TextStyle(fontSize: 36,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                            ),
                          ),


                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Bench Press: '+benchScore.toStringAsPrecision(3).toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Squats: '+deadLiftScore.toStringAsPrecision(3).toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0,5),
                                child: Text('\u2022 Curl: '+squatScore.toStringAsPrecision(3).toString(),
                                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                ),

              ],
            ),
          // Card(
          // color: Colors.white12,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12.0),
          // ),
          // elevation: 15,
          // child:InkWell(
          //     splashColor: Colors.blue.withAlpha(30),
          //     onTap: () {
          //       debugPrint('Card tapped.');
          //     },
          //     child: SizedBox(
          //       width: 186.5,
          //       height: 165,
          //       child: Text("test"),
          // ),),
          //
          //
          //
          // ),
          ]),
        ));
  }
}
