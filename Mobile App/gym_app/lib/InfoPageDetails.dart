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
    List methods=[BenchInfo(),SquatInfo(),CurlInfo()];


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

            child: ListView(
              children: [
                SizedBox(height: 7,),

                Row(
                  children: [
                    SizedBox(width: 10,),
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
                    SizedBox(width: 10,),
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

                SizedBox(height: 10,),




                methods[widget.number],

                SizedBox(height: 20,),






              ],
            ),

          ),



        )
    );

  }

  BenchInfo(){

    return   Container(
      child: Column(
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'The bench press is the quintessential weightlifting \nexercise that primarily targets the pectoralis major, \ndeltoid, and tricep. As shown in the diagram below:',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/benchInfo1.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                      fit: BoxFit.cover,

                    ),
                    borderRadius:  BorderRadius.all(Radius.circular(15.0)),
                  ),
                  alignment: Alignment.center,
                  width: 300,
                  height: 160,
                ),
              ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'To correctly execute the exercise you must first \nmake sure that you are wearing appropriate \ngym attire, and are performing the lift in a safe \nenvironment free of obstacles. Also it doesn’t \nhurt to take a couple minutes to make sure all \nthe equipment is free of defects. Lastly, make\nsure the weight on both sides of the bar are\nequal, and properly clipped.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '1. First we have to lie down on the bench facing\nup towards the bar. A common cue you can use \nto align yourself with the bar, is positioning your \neyes right below the bar.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '2. The next step is to grab a hold of the bar at an \nequal distance. This step varies from person to \nperson depending on your individual anatomy. \nBut usually, your elbows should form a 90 \ndegree angle as shown in the diagram below. \nOvertime you can adjust this position to fit your\nanatomy.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/benchInfo2.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                  fit: BoxFit.cover,

                ),
                borderRadius:  BorderRadius.all(Radius.circular(15.0)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 160,
            ),
          ),




          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '3. The last step in the setup is retracting your \nscapula, and curving your back. This step is \nslightly more advanced, so if you are new to \nbenching feel free to skip it until later. But in this \nstep you puff your chest up, curve your upper \nback, while making sure your glutes remain \nglued to the bench, and make sure your \nshoulders are recessed.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '4. We can now perform the lift. Slowly lower \nthe bar towards the bottom of your chest in an \ninclined bar path as shown in the diagram below. ',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/benchInfo3.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                  fit: BoxFit.cover,

                ),
                borderRadius:  BorderRadius.all(Radius.circular(15.0)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 160,
            ),
          ),




          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '5. On the way up, push the bar back in place \nabove your eyes in a careful manner. ',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  'You have now properly completed one rep of \nthe bench press. Record a video of one rep on \nthe app to see how well you performed the lift.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),



        ],
      ),
    );

  }



  SquatInfo(){

    return   Container(
      child: Column(
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'The squat is one of the most conducive \nexercises for athletic performance. It’s a \ncompound exercise that is known to be one of \nthe most challenging to perfect. There is a lot of \nvariation in squats depending on the individual’s \nanatomy so these steps are only meant to \noutline a proper rep. However, the exercise \nprimarily targets the glutes, hamstrings, and \nquadriceps as shown in the diagram below:',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/SquatInfo1.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                  fit: BoxFit.cover,

                ),
                borderRadius:  BorderRadius.all(Radius.circular(15.0)),
              ),
              alignment: Alignment.center,
              width: 150,
              height: 150,
            ),
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'To correctly execute the exercise you must first \nmake sure that you are wearing appropriate \ngym attire, and are performing the lift in a safe \nenvironment free of obstacles. Also it doesn’t \nhurt to take a couple minutes to make sure all \nthe equipment is free of defects. Lastly, make\nsure the weight on both sides of the bar are\nequal, and properly clipped.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '1. First we have to decide on the proper position \nfor the bar to rest on the back. Like mentioned \nbefore, this can differ from person to person, but \nusually the bar should rest on the trapezius \nmuscle on the back as shown in the diagram below:',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/SquatInfo2.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                  fit: BoxFit.cover,

                ),
                borderRadius:  BorderRadius.all(Radius.circular(15.0)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 170,
            ),
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '2. Second we need to make sure your hands are \nequidistant from each other and far enough to \nhave proper control of the bar on the way down.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),





          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '3. Next, the feet have to be positioned \napproximately shoulder width apart and feet \nfacing forward/slightly out.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '4. Then, slowly squat down without sticking the \nglutes too far out.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),




          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '5. On the way up again, keep glutes in and squat up.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  'Congratulations you have successfully squatted \none rep! Record a video of one rep on the app \nto see how well you performed the lift.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),



        ],
      ),
    );

  }


  CurlInfo(){

    return   Container(
      child: Column(
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'The curl is a relatively simple exercise that \ntargets everyone’s favorite muscle: the biceps. \nThe exercise has a lot of variation to target \ndifferent areas of the bicep, but we will be \nfocusing on the barbell curl.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/CurlInfo1.png'),//FileImage(File('/storage/emulated/0/AudioFiles/Benchvid2.gif')),
                  fit: BoxFit.cover,

                ),
                borderRadius:  BorderRadius.all(Radius.circular(15.0)),
              ),
              alignment: Alignment.center,
              width: 300,
              height: 160,
            ),
          ),


          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'To correctly execute the exercise you must first \nmake sure that you are wearing appropriate \ngym attire, and are performing the lift in a safe \nenvironment free of obstacles. Also it doesn’t \nhurt to take a couple minutes to make sure all \nthe equipment is free of defects. Lastly, make\nsure the weight on both sides of the bar are\nequal, and properly clipped.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '1. First hold the bar, palms facing upwards and \nshoulder width apart.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),



          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '2. Curl the bar upwards while keeping both \nhands in-line with each other.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),





          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  '3. Next control the descent of the bar \nas much as possible to limit any swinging.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),





          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 10,bottom: 0,right: 0),
                child: Text(
                  'Great, you have completed a bicep curl. Record \na video of one rep on the app to see how well \nyou performed the lift.',
                  style: TextStyle(fontSize: 17,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),



        ],
      ),
    );

  }





}
