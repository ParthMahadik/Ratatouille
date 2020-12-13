import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille/models/dish_data.dart';
import 'package:ratatouille/models/networking.dart';

class ResultScreen extends StatefulWidget {
  static const String id = 'result_screen';
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  DishData dishData = new DishData();
  List<String> dishes = [];

  final _firebaseDbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> getDishes() async {
    var result = (await FirebaseDatabase.instance
            .reference()
            .child('recipe')
            .child('list')
            .once())
        .value;
    for (var item in result) {
      dishes.add(item);
    }
    dishes.add('Jalebi');
    dishes.add('Halwa');
    dishes.add('Kheer');
    dishes.add('Milk Pudding');
    return dishes;
  }

  var color1 = const Color(0xff7EC5C1);
  var color2 = const Color(0xffF9D6DC);
  var color3 = const Color(0xffEE4D4D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                child: Text(
                  'The perfect match',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Ramble',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                child: Text(
                  'Imarti',
                  style:
                      GoogleFonts.dancingScript(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/imarti.png",
                  height: 220.0,
                  width: 280.0,
                ),
                InkWell(
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  ),
                  onTap: () {
                    print('side');
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
              child: Text(
                'Other stellar options',
                style: GoogleFonts.rambla(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), color: color2),
                child: FutureBuilder(
                    future: getDishes(),
                    builder: (context, snapshot) {
                      while (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          itemCount: dishes.length - 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 55.0, width: 25.0),
                                  Text(
                                    dishes[index + 1],
                                    style: GoogleFonts.dancingScript(
                                        color: Color(0xff757575), fontSize: 25.0),
                                  ),
                                  SizedBox(height: 55.0, width: 20.0),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xff757575),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50.0,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40.0,
                    child: RaisedButton(
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      color: color3,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Missed something?',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontFamily: 'Rambla',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                    Text(
                      'We got your back',
                      style: GoogleFonts.dancingScript(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      backgroundColor: color1,
    );
  }
}
