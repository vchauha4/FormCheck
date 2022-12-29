import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'ExerciseDetails.dart';
import 'appbarclipper.dart';

/*
add the tracking thing for bottomTabBar
adjust the Card row thing to make it better and arrange evrythnig
then copy it for the info

add the view all buttom that takes u to grid version
add the bench workout with the just the cam feature inapp
 */


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white30,//BackGround color of Page

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],

          // next 3 lines to make it shift, remove to see dif
          type: BottomNavigationBarType.shifting, // Shifting
          selectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(
            color: Color(0xFFfc0811),
          ),
          unselectedItemColor: Color(0xFFfc0811),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(color: Color(0xFF4c7dad), size: 40),

          items: const [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF212121),

              label: "Home",
              icon: Icon(
                Icons.home,
                size: 25,
//              color: Color(0xFFfc0811),

              ),
            ),

            BottomNavigationBarItem(
              backgroundColor: Color(0xFF212121),
              label: "My Workouts",

              icon: Icon(
                Icons.whatshot_outlined,
                size: 25,
              ),
            ),

          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

        ),
        extendBody: true,

        body:  Container(
          child: pageData(context,_selectedIndex),
          //Add padding
          // padding: EdgeInsets.only(top:20 * 2),
        )




    );

  }
  pageData(context,index){
    List<Widget> pages = <Widget>[

      Column(
        children: [
          customAppBar(context)
          //Old app Bar
          //       Stack(
          //           clipBehavior: Clip.none,
          //           children: <Widget>[
          //             ClipPath(
          //               clipper: AppBarClipper(),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.blue[900],
          //                 ),
          //                 height: MediaQuery.of(context).size.height * 0.21,
          //               ),
          //             ),
          //
          //             Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
          //               child: Container(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: const <Widget>[
          //                     Text(
          //                       'AI Gym Assistant ',
          //                       textAlign: TextAlign.start,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'))
          // ,
          //
          //                     IconButton(
          //                       padding: EdgeInsets.all(0),
          //                       icon: Icon(
          //                         Icons.account_circle_sharp,
          //                         size: 32,
          //                         color: Colors.white,
          //                       ),
          //                       onPressed: null,
          //                     )
          //
          //                   ],
          //                 ),
          //                 height: 60,
          //               ),
          //             ),
          //           ]
          //       ),
          ,SizedBox(height: 30,),
          Row(children: [
            // Text(' Workout Exercises:',  textAlign: TextAlign.start,style: TextStyle(fontSize: 29,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),


            // SizedBox(width: 190
            //   ,),

            //Text("View All")
          ],

          ),
          SizedBox(height: 0,),

          playlistGrid(context),

          //Info thing

          // SizedBox(height: 10,),
          // Row(children: [
          //   Text('   Information',  textAlign: TextAlign.start,style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),
          //   SizedBox(width: 180,),
          //
          //   Text("View All")
          // ],),
          //
          // playlistGrid(),
        ],
      ),

      Text(
        'My Workout Page',
      ),

    ];

    return pages.elementAt(index);


  }


}
playlistGrid(context) {

  List images=["Assets/Intermediate-bench-press-program.jpg","Assets/img.jpg","Assets/img_1.jpg","Assets/Intermediate-bench-press-program.jpg","Assets/Intermediate-bench-press-program.jpg",];
  List text=['Bench Press','Dead Lift','Squats','Bench Press','Bench Press',];

// Text(' Workout Exercises:',  textAlign: TextAlign.start,style: TextStyle(fontSize: 29,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),

  Size size = MediaQuery.of(context).size;
  const Color primary = Color(0xFF4FC3F7);
  const Color secondary = Color(0xFFF06292);
  const Color black = Colors.black;
  const Color white = Colors.white;
  const Color blueGrey = Colors.blueGrey;

//padding

  const double appPadding = 20.0;

  return  Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Padding(

          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   'Workout Exercises',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: 1.5,),),
              Text('Workout Exercises:',  textAlign: TextAlign.start,style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),


              Text('See All',  textAlign: TextAlign.start,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),

            ],
          ),
        ),

        Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),

              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: appPadding / 2),
                  child: Container(
                    height: size.height * 0.24,
                    decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                              color: black.withOpacity(0.3),
                              blurRadius: 28.0,
                              offset: Offset(10, 15))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 3, 1),
                      child: Column(
                        children: [
                          Row(
                            children: [


                              Container(
                                width: size.width * 0.9,
                                height: size.height*.185,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              //
                              // Container(
                              //   width: size.width * 0.3,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         left: appPadding / 2, top: appPadding / 1.5),
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Text(
                              //           text[index],
                              //           style: TextStyle(
                              //             color: Colors.blue,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 16,
                              //           ),
                              //           maxLines: 2,
                              //         ),
                              //
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 2,),

                          Row(
                            children: [
                              SizedBox(

                                width: size.width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(text[index],  textAlign: TextAlign.start,style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),


                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );


                // var sName= PlaylistsFolders[count].toString().split('/').last.substring(0,PlaylistsFolders[count].toString().split('/').last.length-1);
                // var imageSaveName=sName.replaceAll(RegExp(r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]', unicode: true),'');

                // return Card(
                //   margin: EdgeInsets.only(left: 10),
                //
                //   // maybe make it a card
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(12.0),
                //   ),
                //   elevation: 15,
                //   color: Colors.grey[900],//Colors.grey[850]?.withOpacity(0.5),
                //   child:InkWell(
                //     splashColor: Colors.red[900],
                //     borderRadius: BorderRadius.circular(50),
                //
                //     onTap: (){
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Exercises(),// make list take a parameter for the folder
                //         ),
                //       );
                //        print("Clicked ");
                //     },
                //
                //     child:Container(
                //
                //       decoration: BoxDecoration(
                //         color: Colors.grey[900],
                //
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       child: ClipRRect(
                //
                //         borderRadius: BorderRadius.circular(12),
                //
                //         child: Column(
                //
                //           mainAxisSize:MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //
                //           children: <Widget>[
                //
                //             Container(
                //
                //               child: Image.asset(images[index],
                //                 fit: BoxFit.fitWidth,
                //                 height: 130,
                //                 width: 240,
                //               ),
                //
                //
                //               alignment: Alignment.center,
                //               height: 130,
                //               width: 240,
                //             ),
                //
                //
                //             Container(
                //               padding: EdgeInsets.all(12),
                //               width: 240,
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //
                //                 children: <Widget>[
                //                   Text(
                //                       text[index],
                //                       style: TextStyle(fontSize: 19,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                //                       overflow: TextOverflow.ellipsis,
                //                       textAlign: TextAlign.center
                //                   ),
                //
                //
                //                 ],
                //               ),
                //
                //             )
                //           ],
                //         ),
                //
                //
                //       ),
                //     ),
                //   ),
                //
                //
                // );
                //


              },


            )
        ),
      ],
    ),
  );
}













customAppBar(context) {

//padding

  const double appPadding = 20.0;
  Size size = MediaQuery.of(context).size;

  return  Container(
    color: Colors.black54,
    child: Padding(
      padding: EdgeInsets.only(left: 15.0,right: 10.0,top: 30,bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [

              Padding(
                padding: const EdgeInsets.all(appPadding / 8),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding / 20),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(appPadding / 8),
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'Assets/itachi.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.015,
              ),
              Text(
                'Itachi Uchiha',
                style: TextStyle(fontSize: 23,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),

                // style: TextStyle(color: black, fontWeight: FontWeight.w600,fontSize: 18),
              ),
            ],
          ),

          Row(
            children: [
              // Stack(
              //   children: [
              //     Icon(
              //       Icons.notifications_none_rounded,
              //       size: 30.0,
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //           color: primary,
              //           borderRadius: BorderRadius.circular(30.0)
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: Text('0',style: TextStyle(color: white,fontSize: 8),),
              //       ),
              //     )
              //   ],
              // ),
              Transform(
                transform: Matrix4.rotationY(math.pi),
                alignment: Alignment.center,
                child: Icon(
                  Icons.sort_rounded,
                  size: 30.0,
                ),
              )
            ],
          )


        ],
      ),
    ),
  );

}











