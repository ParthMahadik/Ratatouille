import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

final StorageReference storageReference = FirebaseStorage().ref();
final _firebaseDbRef = FirebaseDatabase.instance.reference();

class CameraScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final CameraDescription camera;
  CameraScreen(this.camera);
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff7EC5C1),
          title: Text(
            'Search for this ingredient',
            style: GoogleFonts.rambla(),
          )),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          SizedBox(height: 20.0),
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
                    print(imagePath);
                    var ref = storageReference.child('ingredient');
                    await ref.delete();
                    StorageUploadTask uploadTask = storageReference
                        .child('ingredient')
                        .putFile(File(imagePath));
                  },
                  minWidth: 150.0,
                  height: 30.0,
                  child: Text(
                    "Use AI to identify this ingredient !",
                    style: GoogleFonts.rambla(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //Text('Use AI to identify this ingredient'),
            ),
          ),
        ],
      ),
    );
  }
}
