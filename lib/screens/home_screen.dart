import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille/screens/ingredients_page.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7EC5C1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180.0,
                  width: double.infinity,
                ),
                Text(
                  'Ratatouille',
                  style:
                      GoogleFonts.dancingScript(color: Colors.white, fontSize: 60.0),
                ),
                SizedBox(
                  height: 10.0,
                  width: double.infinity,
                ),
                Text(
                  'Unleash your inner chef',
                  style: GoogleFonts.rambla(color: Colors.white, fontSize: 15.0),
                ),
                SizedBox(
                  height: 80.0,
                  width: double.infinity,
                ),
                Material(
                  elevation: 5.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      print('pressed');
                      Navigator.pushNamed(context, IngredientsScreen.id);
                    },
                    minWidth: 200.0,
                    height: 40.0,
                    child: Text(
                      "Let's get cooking!",
                      style: GoogleFonts.rambla(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Image.asset(
                'images/home.png',
                height: 120.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
