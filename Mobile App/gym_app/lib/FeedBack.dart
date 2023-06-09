import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_app/HomePage.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Boxes.dart';
import 'modelClassStats.dart';
import 'package:http/http.dart' as http;

class FeedBack extends StatefulWidget {
  final int number;
  final String path;

  const FeedBack({Key? key, required this.number, required this.path}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {


@override
  void initState() {

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    super.initState();
  }

@override
  void dispose() {
  Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

  late List<String>  feedBackListServer;
  double scoreFromServer=0;

  Future<void> updateStats(double score) async {
  int number=widget.number;

  final myBox= Boxes.getData();
  // myBox.put(0, DataStats(1,1,1,1,1,1));
  // final datastat=DataStats()
  // ..BenchCount=0;
  //
  // myBox.put('user', datastat);




    // Box open= await Hive.openBox<DataStats>('stats') ;



    // open.put(2,5);

  //   print(myBox.getAt(0));
  //   final ceda=myBox.values.toList().cast<DataStats>();
  // print(ceda.first);
  final myData= myBox.get('user');





  if(number==0){

    int? curentBench=myData?.BenchCount;
    if(curentBench==null){
      curentBench=0;
    }

    curentBench=(curentBench!+1)!;



    double? benchScore=myData?.BenchScore;
    if(benchScore==null){
      benchScore=0;
    }

    benchScore=(benchScore!+score)!;


    double? squatScore=myData?.SquatsScore;
    if(squatScore==null){
      squatScore=0;
    }    double? deadLiftScore=myData?.DeadliftScore;
    if(deadLiftScore==null){
      deadLiftScore=0;
    }


    int? curentSquats=myData?.SquatsCount;
    if(curentSquats==null){
      curentSquats=0;
    }
    int? curentDeadLift=myData?.DeadliftCount;
    if(curentDeadLift==null){
      curentDeadLift=0;
    }




    // if(myData?.BenchCount!=null){
      final datastat=DataStats()
        ..BenchCount=curentBench
        ..SquatsCount=curentSquats
        ..DeadliftCount=curentDeadLift
        ..BenchScore=benchScore
        ..DeadliftScore=deadLiftScore
        ..SquatsScore=squatScore;



      myData?.box?.put('user', datastat);
    // }
    // else{
    //   final datastat=DataStats()
    //     ..BenchCount=myData!.BenchCount+1;
    //
    //   myBox.put('user', datastat);
    // }
  }


  else if(number==2){
    int? curentSquats=myData?.SquatsCount;
    if(curentSquats==null){
      curentSquats=0;
    }
    curentSquats=(curentSquats!+1)!;


    double? benchScore=myData?.BenchScore;
    if(benchScore==null){
      benchScore=0;
    }



    double? squatScore=myData?.SquatsScore;
    if(squatScore==null){
      squatScore=0;
    }
    squatScore=(squatScore!+score)!;


    double? deadLiftScore=myData?.DeadliftScore;
    if(deadLiftScore==null){
      deadLiftScore=0;
    }



    int? curentDeadLift=myData?.DeadliftCount;
    if(curentDeadLift==null){
      curentDeadLift=0;
    }
    int? curentBench=myData?.BenchCount;
    if(curentBench==null){
      curentBench=0;
    }

    final datastat=DataStats()
      ..SquatsCount=curentSquats
      ..BenchCount=curentBench
      ..DeadliftCount=curentDeadLift
      ..BenchScore=benchScore
      ..DeadliftScore=deadLiftScore
      ..SquatsScore=squatScore;


    myBox.put('user', datastat);





  }
  else if(number==1){
    int? curentDeadlift=myData?.DeadliftCount;
    if(curentDeadlift==null){
      curentDeadlift=0;
    }
    curentDeadlift=(curentDeadlift!+1)!;


    double? benchScore=myData?.BenchScore;
    if(benchScore==null){
      benchScore=0;
    }



    double? squatScore=myData?.SquatsScore;
    if(squatScore==null){
      squatScore=0;
    }


    double? deadLiftScore=myData?.DeadliftScore;
    if(deadLiftScore==null){
      deadLiftScore=0;
    }

    deadLiftScore=(deadLiftScore!+score)!;


    int? curentBench=myData?.BenchCount;
    if(curentBench==null){
      curentBench=0;
    }
    int? curentSquats=myData?.SquatsCount;
    if(curentSquats==null){
      curentSquats=0;
    }


    final datastat=DataStats()
      ..DeadliftCount=curentDeadlift
      ..SquatsCount=curentSquats
      ..BenchCount=curentBench
      ..BenchScore=benchScore
      ..DeadliftScore=deadLiftScore
      ..SquatsScore=squatScore;

    myBox.put('user', datastat);

  }


  final myDatUpdated= myBox.get('user');

  print('Here '+number.toString());
  print(myBox.getAt(0)?.BenchCount);
  print(myBox.getAt(0)?.SquatsCount);

  print('Bench ');

  print(myDatUpdated?.BenchCount);
  print('Squats ');

  print(myDatUpdated?.SquatsCount);
  print('Deadlift ');

  print(myDatUpdated?.DeadliftCount);

  print('BenchScore ');

  print(myDatUpdated?.BenchScore);
  print('Squats Score');

  print(myDatUpdated?.SquatsScore);
  print('Deadlift Score');

  print(myDatUpdated?.DeadliftScore);

  }
Future<String> getData() async {

    if(widget.number==0) {

      print("GOING IN THE GET REQUEST");

      // http.Response res = await http.get(Uri.parse("https://www.google.com"));

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://3.145.174.64/predict?exerciseType=0'));

      final fileName = widget.path; // will return you the name of your file like REC9113430186235591563.mp4

      print("HERE IS THE FILENAME 280"+fileName);

      request.files.add(await http.MultipartFile.fromPath('videos',
          '/storage/emulated/0/Android/data/com.example.gym_app/Files/bench.mp4'));


      http.StreamedResponse response = await request.send();


      String responceServer = '';


      if (response.statusCode == 200) {
        responceServer = await response.stream.bytesToString();
      }
      else {
        print(response.reasonPhrase);
      }

      print("HERE IS THE RESPONSE" + response.reasonPhrase.toString());


      // scoreFromServer= double.parse(response.reasonPhrase['Results'].toString());
      print("LINE 295");
      print(responceServer);

      // String result = responceServer.substring(responceServer.indexOf('Results'));
      // print(result);
      //
      // print(result.split(' '));
      // scoreFromServer= double.parse(result.split(' ')[4]);

      // setState(() {
      //   scoreFromServer=scoreFromServer;
      // });


      return responceServer;

//I/flutter (23612): {'Recommendations': ["OBSERVATION: You're lifting the bar all the way to the top! Good job! 178.7223807860361 , 178.7223807860361", "RECCOMENDATION: Try to move you're arms further apart - They might be too close together"],
// 'Results': 'Your score: 28.139841895111342 Your form not optimal'}}
    }
    else if(widget.number==1)
    {
        print("GOING IN THE GET REQUEST");

        // http.Response res = await http.get(Uri.parse("https://www.google.com"));

        var request = http.MultipartRequest(
            'POST', Uri.parse('http://3.145.174.64/predict?exerciseType=1'));


        final fileName = widget.path; // will return you the name of your file like REC9113430186235591563.mp4
        print("HERE IS THE FILENAME 280"+fileName);

        request.files.add(await http.MultipartFile.fromPath('videos',
            '/storage/emulated/0/Android/data/com.example.gym_app/Files/$fileName'));


        http.StreamedResponse response = await request.send();


        String responceServer = '';


        if (response.statusCode == 200) {
          responceServer = await response.stream.bytesToString();
        }
        else {
          print(response.reasonPhrase);
        }

        print("HERE IS THE RESPONSE" + response.reasonPhrase.toString());


        // scoreFromServer= double.parse(response.reasonPhrase['Results'].toString());
        print("LINE 295");
        print(responceServer);

        // String result = responceServer.substring(responceServer.indexOf('Results'));
        // print(result);
        //
        // print(result.split(' '));
        // scoreFromServer= double.parse(result.split(' ')[4]);

        // setState(() {
        //   scoreFromServer=scoreFromServer;
        // });


        return responceServer;

//I/flutter (23612): {'Recommendations': ["OBSERVATION: You're lifting the bar all the way to the top! Good job! 178.7223807860361 , 178.7223807860361", "RECCOMENDATION: Try to move you're arms further apart - They might be too close together"],
// 'Results': 'Your score: 28.139841895111342 Your form not optimal'}}
      }
    else if(widget.number==2)
    {
      print("GOING IN THE GET REQUEST");

      // http.Response res = await http.get(Uri.parse("https://www.google.com"));

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://3.145.174.64/predict?exerciseType=2'));


      final fileName = widget.path; // will return you the name of your file like REC9113430186235591563.mp4
      print("HERE IS THE FILENAME 280"+fileName);

      request.files.add(await http.MultipartFile.fromPath('videos',
          '/storage/emulated/0/Android/data/com.example.gym_app/Files/$fileName'));
//          '/storage/emulated/0/Android/data/com.example.gym_app/Files/$fileName'));

      http.StreamedResponse response = await request.send();


      String responceServer = '';


      if (response.statusCode == 200) {
        responceServer = await response.stream.bytesToString();
      }
      else {
        print(response.reasonPhrase);
      }

      print("HERE IS THE RESPONSE" + response.reasonPhrase.toString());


      // scoreFromServer= double.parse(response.reasonPhrase['Results'].toString());
      print("LINE 295");
      print(responceServer);

      // String result = responceServer.substring(responceServer.indexOf('Results'));
      // print(result);
      //
      // print(result.split(' '));
      // scoreFromServer= double.parse(result.split(' ')[4]);

      // setState(() {
      //   scoreFromServer=scoreFromServer;
      // });


      return responceServer;

//I/flutter (23612): {'Recommendations': ["OBSERVATION: You're lifting the bar all the way to the top! Good job! 178.7223807860361 , 178.7223807860361", "RECCOMENDATION: Try to move you're arms further apart - They might be too close together"],
// 'Results': 'Your score: 28.139841895111342 Your form not optimal'}}
    }



    return 'null';
  }







  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    List<String>  feedBackList2=['Arms Too Wide','Bar is unbalanced'];
    double score=80.42;
    List text=['Bench Press ','Squats ','Curl ',];
    print('Line303 -----------------------------------------------------------------------------------------------------------------------------------' );

    // getData().then((value) => {
    //   print(value),
    //
    //   // scoreFromServer=double.parse(value)
    //
    //
    // });


    // scoreFromServer= getData().then((value) => print(value)) ;

    return Scaffold(
        resizeToAvoidBottomInset: false,

        backgroundColor: const Color(0xFF212224),


      // appBar: AppBar(
      //   title: Text("Bench Press FeedBack"),
      //   backgroundColor: Colors.black38,
      //   elevation: 5,
      //   leading: Icon(Icons.home),
      // ),


      body: FutureBuilder(
        future: getData(),

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print('Line 390');
          print(snapshot.error);
          print(snapshot.toString());
          print(snapshot.connectionState);

          if(snapshot.hasData){
            // final body2 = json.encode(snapshot.data);
            //
            // final body = json.decode(body2);
            // var user = jsonDecode(snapshot.data);
            // var score=user['score'];
            // print(score);
            print("HASSSSS DATA");

            const jsonString ='{"recc_arra":["OBSERVATION: Youre lifting the bar all the way to the top! Good job! 178.7223807860361 , 178.7223807860361","RECCOMENDATION: Try to move youre arms further apart - They might be too close together"],"score":"28.139841895111342"}';
            print("NOTHING:::::: "+snapshot.data.toString());

            var data;
            List<String>  feedBackList=[''];
            String formOp='';
            double score=0;

            try{
               data = jsonDecode(snapshot.data);
               print(data['recc_arra']); // foo
               print(data['score']); // 1
               score=  double.parse(data['score'].toString());

               // print(user.runtimeType);
               // print(user['score']);
               // print(user[1]);

               print('Line 401');
               print(data['recc_arra'].toString().split(',')); // 1

               feedBackList=data['recc_arra'].toString().split(',');


               print(snapshot.connectionState);
               if(score>60){
                 formOp='Based on your above score, your form is considered to be optimal:';
               }
               else
               {
                 formOp='Based on your above score, your form is considered to not be optimal:';

               }

               updateStats(score);
            }
            catch(e){
              print(e);

            }



            return NestedScrollView(
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(), //CameraPage(number: widget.number,),// make list take a parameter for the folder
                              ),
                            );
                            print("Clicked ");
                          },
                          icon: Icon(Icons.home, size: 30,)

                      ),
                      // titleSpacing: 5,
                      forceElevated: false,


                      title: Center(child: Text(
                        text[widget.number].toString() + "Feedback   ",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Proxima Nova'),)),
                      backgroundColor: const Color(0xFF111213),
                      pinned: true,
                      floating: true,
                      elevation: 20,
                      centerTitle: true,
                      expandedHeight: 80.0,
                      collapsedHeight: 75,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      shadowColor: Colors.red[300],
                      toolbarHeight: 70,


                    ),

                  ];
                },
                body: Container(
                  decoration: BoxDecoration(

                    //image: DecorationImage(image: FileImage(File('/storage/emulated/0/files/pictures/itachi.jpg')), fit: BoxFit.cover, opacity: 0.1),//HERE IS backgroundColor

                      gradient: LinearGradient(
                          colors: [Color(0xFF424242), Color(0xFF212121)],
                          stops: [0.1, 0.7],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          tileMode: TileMode.repeated)),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: score / 100,
                          center: Text(
                              score.toString() + "%",
                              style: TextStyle(fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Proxima Nova')),
                          footer: Text(
                              "Your Score",
                              style: TextStyle(fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Proxima Nova')
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.red[900],
                          backgroundColor: Colors.black54,


                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Flexible(
                            child: Text(
                                formOp,
                                textAlign: TextAlign.start, style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima Nova')),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
                          child: Flexible(
                            child: Text(
                                'Feedback is provided below to improve your score:',
                                textAlign: TextAlign.start, style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima Nova')),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                                children:
                                feedBackList.map((name) {
                                  return Row(
                                      children: [

                                        Text("\u2022", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Proxima Nova')),
                                        //bullet text

                                        SizedBox(width: 10,),
                                        //space between bullet and text

                                        Expanded(
                                          child: Text(
                                              name, textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 23,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Proxima Nova')), //text
                                        )
                                      ]
                                  );

                                }


                                ).toList()


                            ),
                          ),
                        ),




                      ],
                    ),


                  ),
                )


            );
          }


          else{


            return Container(
                child: Center(
                    child: SpinKitFadingCube(
                          color: Colors.blue[900],
                          size: 90.0
                      )


                    // Center(
                    //   child: CircularProgressIndicator(
                    //     color: Colors.blue,
                    //   ),
                    // ),
                    // SpinKitFadingCube(
                    //     color: Colors.lightGreen[100],
                    //     size: 50.0
                    // )
                )
            );;
          }

          print('LINE 360');
          print(snapshot.hasData);





        },


      ),



    );



  }

  listFeedBack(feedBackList){
    feedBackList.map((strone){
      return Row(
          children:[
            Text(
          "\u2022", style: TextStyle(fontSize: 30),), //bullet text
            SizedBox(width: 10,), //space between bullet and text
            Expanded(
              child:Text(strone, style: TextStyle(fontSize: 30),), //text
            )
          ]
      );
    }).toList();
  }

}
