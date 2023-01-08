import 'package:flutter/material.dart';
import 'package:gym_app/HomePage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FeedBack extends StatefulWidget {
  final int number;

  const FeedBack({Key? key, required this.number}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    List<String>  feedBackList=['Arms Too Wide','Bar is unbalanced'];
    double score=80.4;
    List text=['Bench Press ','Dead Lift ','Squats ','Bench Press ','Bench Press ',];


    return Scaffold(
      backgroundColor: const Color(0xFF212224),


      // appBar: AppBar(
      //   title: Text("Bench Press FeedBack"),
      //   backgroundColor: Colors.black38,
      //   elevation: 5,
      //   leading: Icon(Icons.home),
      // ),


      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), //CameraPage(number: widget.number,),// make list take a parameter for the folder
                  ),
                );
                print("Clicked ");

              },
              icon: Icon(Icons.home, size: 30,)

          ),
          // titleSpacing: 5,
          forceElevated: false,


          title: Center(child:Text(text[widget.number].toString()+"Feedback",  textAlign: TextAlign.justify,style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),)),
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
          shadowColor:Colors.red[300],
          toolbarHeight: 70,



        ),

      ];
    },
    body: Container(
      decoration:  BoxDecoration(

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
            vertical: 45
        ),
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: score/100,
                  center: Text(
                    score.toString()+"%",
                      style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')                ),
                  footer: Text(
                    "Your Score",
                      style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.red[900],
                  backgroundColor: Colors.black54,


          ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Flexible(
                    child: Text('Based on your above score, your form is considered to be optimal:',  textAlign: TextAlign.start,style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0,5),
                  child: Flexible(
                    child: Text('Feedback is provided below to improve your score:',  textAlign: TextAlign.start,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children:
                      feedBackList.map((name){
                            return Row(
                            children:[

                              Text("\u2022",textAlign: TextAlign.start,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')), //bullet text

                              SizedBox(width: 10,), //space between bullet and text

                              Expanded(
                                  child:Text(name, textAlign: TextAlign.start,style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')), //text
                                  )
                                ]
                              );
                            }).toList()



                  ),
                ),
              ],
            ),



      ),
    )


    )



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
