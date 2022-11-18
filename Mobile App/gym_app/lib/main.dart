import 'package:flutter/material.dart';
import 'package:gym_app/HomePage.dart';

import 'appbarclipper.dart';

void main() {
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,

    theme: ThemeData(
        brightness:  Brightness.dark
    ),
    initialRoute:'/Playlists' ,
    routes: {
      //'/':(context)=> AudioPlay(number: -1),
      //   '/listing':(context)=> Lists(folderName:" Directory: '/storage/emulated/0/AudioFiles/君の名は。 (Kimi no Na wa.) (Your Name.) (Full Original Soundtrack)'"),
      '/Playlists':(context)=> HomePage(),
      //'/youtube':(context)=>  MyHomePage(title: 'Flutter Demo Home Page'),

    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.ac_unit,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.ac_unit,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.ac_unit,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.ac_unit,
              size: 20,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              DashboardStat(),
              SizedBox(
                height: 10,
              ),
              heading('RECENT CHALLENGES', context),
              ChallengesSlider(),
              heading('COMPLETED GOALS', context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Column(
                  children: <Widget>[StatCard(), StatCard(), StatCard()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding heading(String sectionName, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            sectionName,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              switch (sectionName.toLowerCase()) {
                case "recent challenges":
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return SizedBox();
                  }));
                  break;
                default:
              }
            },
            child: Text(
              'VIEW ALL',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
                color: Colors.redAccent,
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 17),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 18,
      ),
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 1,
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
            child: Icon(
              Icons.ac_unit,
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '10km Run',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        size: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '120mins',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        size: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '490kcal',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        size: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '20/12',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class ChallengesSlider extends StatelessWidget {
  const ChallengesSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ChallengeCard();
        },
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                'https://images.unsplash.com/photo-1526938084645-692eb352bf7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1225&q=80',
                fit: BoxFit.cover,
              ),
              height: 100,
              width: 240,
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Loss 5Kgs in 1 Week',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Colors.grey,
                            size: 12,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            '1250',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.card_giftcard,
                            color: Colors.grey,
                            size: 12,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            '\$5,250',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardStat extends StatelessWidget {
  const DashboardStat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        ClipPath(
          clipper: AppBarClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
            height: MediaQuery.of(context).size.height * 0.35,
          ),
        ),
        Positioned(
          top: -65,
          left: MediaQuery.of(context).size.width * .55,
          bottom: 55,
          right: -95,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .35)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'My Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: null,
                )
              ],
            ),
            height: 60,
          ),
        ),
        Positioned(
          top: 90,
          left: 25,
          right: 25,
          bottom: -15,
          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 40, right: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "TODAY'S GOAL",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontFamily: 'Montserrat',
                            fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '1,200',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        'KCAL',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Calories',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '90',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Cardio',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0.25,
                    minWidth: double.infinity,
                    onPressed: () {},
                    color: Colors.grey[100],
                    child: Text(
                      'start challenge'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

