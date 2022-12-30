import 'dart:io';
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'Camera.dart';
import 'appbarclipper.dart';

class Exercises extends StatefulWidget {
  final int number;

  const Exercises({Key? key, required this.number}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {

  //  permission_handler: ^10.2.0
  // void initPlayerPermission() async {
  //   final status = await Permission.storage.status;
  //   const statusManageStorage = Permission.manageExternalStorage;
  //   if (status.isDenied ||
  //       !status.isGranted ||
  //       !await statusManageStorage.isGranted) {
  //     await [
  //       Permission.storage,
  //       Permission.mediaLibrary,
  //       Permission.requestInstallPackages,
  //       Permission.manageExternalStorage,
  //       Permission.accessMediaLocation,
  //
  //     ].request();
  //   }
  //
  // Directory directory2 = await getExternalStorageDirectory() as Directory;
  // }

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

    List text=['Bench Press      ','Dead Lift      ','Squats      ','Bench Press      ','Bench Press      ',];


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
              image: DecorationImage(image: FileImage(File('/storage/emulated/0/AudioFiles/itachi.jpg')), fit: BoxFit.cover, opacity: 0.1),//HERE IS backgroundColor

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
                          'Instructions:',
                          style: TextStyle(fontSize: 25,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15,),
                      Text(
                          'Position the camera to record the video as',
                          style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        softWrap: true,
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15,),
                      Text(
                          'shown in the example below.',
                          style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File('/storage/emulated/0/AudioFiles/itachi.jpg')),
                          fit: BoxFit.cover,

                        ),
                        borderRadius:  BorderRadius.all(Radius.circular(15.0)),
                      ),
                      alignment: Alignment.center,
                      width: 380,
                      height: 380,
                    ),
                  ),//Size

                  SizedBox(height: 20,),
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt,
                    size: 27
                    ),

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraPage(number: widget.number,),// make list take a parameter for the folder
                        ),
                      );
                      print("Clicked ");

                    },
                    label: Text("Camera",
                      style: TextStyle(fontSize: 20,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color:
                         // Color(0xFFC62828),
                           Colors.black,
                          width: 2.0,
                        ),// <-- Radius
                      ),
                      backgroundColor: Colors.grey[850],
                      foregroundColor: Colors.white,
                      minimumSize: Size(140, 52),
                    ),
                  )


                ],
              ),

    ),



    )
    );

  }
}
