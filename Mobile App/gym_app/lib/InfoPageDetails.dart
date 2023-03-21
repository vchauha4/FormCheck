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

    List text=['Bench Press    ','Squats    ','Curls      ',];
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
                    SizedBox(width: 15,),
                    Text(
                        'Below we provide information that \nexplains how to properly perform\n'+text2[widget.number]+':',
                        style: TextStyle(fontSize: 21,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     SizedBox(width: 10,),
                //     Text(
                //       'how to properly perform '+text2[widget.number]+':',
                //       style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                //       overflow: TextOverflow.ellipsis,
                //       textAlign: TextAlign.start,
                //       softWrap: true,
                //     ),
                //
                //   ],
                // ),
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

                SizedBox(height: 15,),




                methods[widget.number],

               // SizedBox(height: 20,),






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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),  //.only(left: 8,top: 0,bottom: 0,right: 0),
                child: Text(
                  'The bench press is the quintessential \nweightlifting exercise that primarily \ntargets the pectoralis major, deltoid, and\ntricep. As shown in the diagram below:',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'To correctly execute the exercise you \nmust first make sure that you are \nwearing appropriate gym attire, and are \nperforming the lift in a safe environment \nfree of obstacles. Also it doesn’t hurt to \ntake a couple minutes to make sure all \nthe equipment is free of defects. Lastly, \nmake sure the weight on both sides of \nthe bar are equal, and properly clipped.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '1. First we have to lie down on the \nbench facing up towards the bar. A \ncommon cue you can use to align \nyourself with the bar, is positioning your \neyes right below the bar.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '2. The next step is to grab a hold of \nthe bar at an equal distance. This step \nvaries from person to person \ndepending on your individual \nanatomy. But usually, your elbows \nshould form a 90 degree angle as \nshown in the diagram below. Overtime \nyou can adjust this position to fit your\nanatomy.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '3. The last step in the setup is \nretracting your scapula, and curving \nyour back. This step is slightly more \nadvanced, so if you are new to \nbenching feel free to skip it until later. \nBut in this step you puff your chest up,\ncurve your upper back, while making\nsure your glutes remain glued to the \nbench, and make sure your shoulders\nare recessed.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '4. We can now perform the lift. Slowly \nlower the bar towards the bottom of \nyour chest in an inclined bar path as\n shown in the diagram below. ',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '5. On the way up, push the bar back \nin place above your eyes in a careful\nmanner. ',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'You have now properly completed \none rep of the bench press. Record a \nvideo of one rep on the app to see how \nwell you performed the lift.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'The squat is one of the most \nconducive exercises for athletic \nperformance. It’s a compound exercise\nthat is known to be one of the most \nchallenging to perfect. There is a lot \nof variation in squats depending on the\nindividual’s anatomy so these steps \nare only meant to outline a proper \nrep. However, the exercise primarily \ntargets the glutes, hamstrings, and \nquadriceps as shown in the diagram\nbelow:',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'To correctly execute the exercise you \nmust first make sure that you are \nwearing appropriate gym attire, and are \nperforming the lift in a safe environment \nfree of obstacles. Also it doesn’t hurt to \ntake a couple minutes to make sure all \nthe equipment is free of defects. Lastly, \nmake sure the weight on both sides of \nthe bar are equal, and properly clipped.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '1. First we have to decide on the proper\nposition for the bar to rest on the back.\nLike mentioned before, this can differ\nfrom person to person, but usually the \nbar should rest on the trapezius muscle\non the back as shown in the diagram\nbelow:',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '2. Second we need to make sure your\nhands are equidistant from each other\nand far enough to have proper control of\nthe bar on the way down.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '3. Next, the feet have to be positioned \napproximately shoulder width apart and \nfeet facing forward/slightly out.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '4. Then, slowly squat down without \nsticking the glutes too far out.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '5. On the way up again, keep glutes in \nand squat up.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'Congratulations you have successfully\nsquatted one rep! Record a video of one\nrep on the app to see how well you \nperformed the lift.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'The curl is a relatively simple exercise\nthat targets everyone’s favorite muscle:\nthe biceps. The exercise has a lot of \nvariation to target different areas of the\nbicep, but we will be focusing on the \nbarbell curl.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'To correctly execute the exercise you \nmust first make sure that you are \nwearing appropriate gym attire, and are \nperforming the lift in a safe environment \nfree of obstacles. Also it doesn’t hurt to \ntake a couple minutes to make sure all \nthe equipment is free of defects. Lastly, \nmake sure the weight on both sides of \nthe bar are equal, and properly clipped.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '1. First hold the bar, palms facing \nupwards and shoulder width apart.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '2. Curl the bar upwards while keeping\nboth hands in-line with each other.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  '3. Next control the descent of the bar \nas much as possible to limit any\nswinging.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Text(
                  'Great, you have completed a bicep curl.\nRecord a video of one rep on the app\nto see how well you performed the lift.',
                  style: TextStyle(fontSize: 18,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
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
