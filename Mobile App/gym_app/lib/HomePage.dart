


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: Colors.green,
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

      body:  Container(
        child: pageData(context,_selectedIndex),
        //Add padding
        padding: EdgeInsets.only(top: 0),
      )




);

  }
pageData(context,index){
  List<Widget> pages = <Widget>[

    Column(
      children: [
        Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              ClipPath(
                clipper: AppBarClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                  ),
                  height: MediaQuery.of(context).size.height * 0.21,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'AI Gym Assistant ',
                        textAlign: TextAlign.start,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'))
  ,

                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.account_circle_sharp,
                          size: 32,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      )

                    ],
                  ),
                  height: 60,
                ),
              ),
            ]
        ),
        SizedBox(height: 0,),
        Row(children: [
  Text('   Exercises',  textAlign: TextAlign.start,style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),


          SizedBox(width: 210,),

          Text("View All")
  ],

        ),
        SizedBox(height: 1,),

        playlistGrid(),


        SizedBox(height: 10,),
        Row(children: [
          Text('   Information',  textAlign: TextAlign.start,style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Proxima Nova')),
          SizedBox(width: 190,),

          Text("View All")
        ],),

        playlistGrid(),
      ],
    ),

    Text(
      'My Workout Page',
    ),

  ];

  return pages.elementAt(index);


}


}
playlistGrid() {

List images=["Assets/Intermediate-bench-press-program.jpg","Assets/img.jpg","Assets/img_1.jpg"];
List text=['Bench Press','Dead Lift','Squats'];

  return  Container(
      height: 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {


      // var sName= PlaylistsFolders[count].toString().split('/').last.substring(0,PlaylistsFolders[count].toString().split('/').last.length-1);
      // var imageSaveName=sName.replaceAll(RegExp(r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]', unicode: true),'');

      return Card(
        margin: EdgeInsets.only(left: 10),

        // maybe make it a card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 15,
        color: Colors.grey[900],//Colors.grey[850]?.withOpacity(0.5),
        child:InkWell(
          splashColor: Colors.red[900],
          borderRadius: BorderRadius.circular(50),

          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Exercises(),// make list take a parameter for the folder
              ),
            );
             print("Clicked ");
          },

          child:Container(

            decoration: BoxDecoration(
              color: Colors.grey[900],

              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(

              borderRadius: BorderRadius.circular(12),

              child: Column(

                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[

                  Container(

                    child: Image.asset(images[index],
                      fit: BoxFit.fitWidth,
                      height: 130,
                      width: 240,
                    ),


                    alignment: Alignment.center,
                    height: 130,
                    width: 240,
                  ),


                  Container(
                    padding: EdgeInsets.all(12),
                    width: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Text(
                            text[index],
                            style: TextStyle(fontSize: 19,color: Color(0xFFfffcfc),fontWeight: FontWeight.bold,fontFamily:'Proxima Nova'),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center
                        ),


                      ],
                    ),

                  )
                ],
              ),


            ),
          ),
        ),


      );
    },


  )
  );
}



