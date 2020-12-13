import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille/models/camera.dart';
import 'package:ratatouille/screens/result_page.dart';
import 'package:ratatouille/models/ingredient_data.dart';

int count = 1;
List<String> ingredients = [];
String item;

class IngredientsScreen extends StatefulWidget {
  static const String id = 'ingredients_screen';

  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  IngredientData ingredientData = new IngredientData();
  final _firebaseDbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7EC5C1),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () {
          Navigator.pushNamed(context, CameraScreen.id);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Have anything in mind?',
                  style: GoogleFonts.dancingScript(
                      color: Colors.white, fontSize: 30.0)),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "\tLet's find the perfect one for you :)",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      print('oof');
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  //Image.asset('images/search.png'),
                ),
                onChanged: (value) {
                  print('search pressed');
                },
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30.0,
                    ),
                    Text(
                      "or Don't know where to start?",
                      style: GoogleFonts.dancingScript(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Just open your fridge and tell us what you find!',
                      style: GoogleFonts.rambla(
                          color: Color(0xff737373), fontSize: 17.0),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff7EC5C1),
                          hintText: "\tName of ingredient",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              print('oof');
                              if (item != null) {
                                setState(() {
                                  ingredients.add(item);
                                });
                              }
                              print(ingredients);
                            },
                            child: Icon(
                              Icons.subdirectory_arrow_left_rounded,
                              color: Colors.white,
                            ),
                          ),
                          //Image.asset('images/search.png'),
                        ),
                        onChanged: (value) {
                          item = value;
                          print('enter pressed');
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Color(0xffF9D6DC),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 10.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ingredients[index],
                                    style: GoogleFonts.rambla(fontSize: 20.0),
                                  ),
                                  InkWell(
                                      onTap: () => deleteItem(index),
                                      child: Image.asset('images/cross.png'))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Material(
                      elevation: 5.0,
                      color: Color(0xff4D9194),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () async {
                              print('pressed');
                              await _firebaseDbRef.child('ingredient').set(
                                {'list': ingredients},
                              );
                              Navigator.pushNamed(context, ResultScreen.id);
                            },
                            minWidth: 150.0,
                            height: 30.0,
                            child: Text(
                              "Let the magic begin !",
                              style: GoogleFonts.rambla(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteItem(index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }
}
