import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ratatouille/models/camera.dart';
import 'package:ratatouille/screens/home_screen.dart';
import 'package:ratatouille/screens/ingredients_page.dart';
import 'package:ratatouille/screens/result_page.dart';

CameraDescription firstCamera;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        IngredientsScreen.id: (context) => IngredientsScreen(),
        ResultScreen.id: (context) => ResultScreen(),
        CameraScreen.id: (context) => CameraScreen(firstCamera),
      },
      home: HomeScreen(),
    );
  }
}
