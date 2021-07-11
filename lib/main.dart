import 'dart:io';
import 'dart:async';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tflite/tflite.dart';

File imageFile;
var CroppedImage;
File _image;
File image;
const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.black,
      image : Image.asset('assets/images/logo2.png'),
      loaderColor: Colors.cyanAccent,
      photoSize: 150.0,
      navigateAfterSeconds: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

enum choice { kitchen, living_room, bedroom, bath }

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static String option1;
  choice _site;
  bool nextchoice = false;

  showAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please make a choice."),
    );
    TextButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text('OK'),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[

        ListTile(),
        ListTile(
          title: const Text('study room',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.bedroom,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice = true;
                option1='study room';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('bath',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.bath,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='bath';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('living room',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.living_room,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='living room';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('kitchen',
            style: TextStyle(color: Colors.white),),
          leading: Radio(
            value: choice.kitchen,
            groupValue: _site,
            onChanged: (choice value) {
              setState(() {
                _site = value;
                nextchoice=true;
                option1='kitchen';
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              child: RaisedButton.icon(
                onPressed: (){
                  if(nextchoice){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>landingscreen()),
                    );
                  }
                  else {
                    showAlertDialog();
                  }
                },
                icon: Icon(Icons.navigate_next_rounded),
                label: Text('NEXT'),
                color: Colors.white,
              )
          ),
        ),
      ],
    );
  }
}

class landingscreen extends StatefulWidget{
  @override
  _landingscreenstate createState() => _landingscreenstate();
}

class _landingscreenstate extends State<landingscreen> {

  bool imageselected=false;
  _openGallery(BuildContext context)async{
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile=picture;
      imageselected=true;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile=picture;
      imageselected=true;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('make a choice'),
        content: SingleChildScrollView(
          child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("gallery"),
                  onTap: (){
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("camera"),
                  onTap: (){
                    _openCamera(context);
                  },
                ),
              ]
          ),
        ),
      );
    },);
  }

  Widget _Image(){
    if(imageFile != null){
      return Image.file(imageFile);

    }
    else{
      return Text('No image selected');
    }
  }

  void alertdialogue() {

    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Select an image"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _Image(),
              // ignore: deprecated_member_use
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // ignore: deprecated_member_use
                  child: RaisedButton(onPressed: (){
                    _showChoiceDialog(context);
                  },child: Text('select image'),),
                ),
              ),
              // ignore: deprecated_member_use
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  // ignore: deprecated_member_use
                  child:RaisedButton(onPressed: (){
                    if (imageselected){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>MyHomePage()),);
                    }
                    else
                    {
                      alertdialogue();
                    }
                  },
                    child: Text('next'),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CropImage(
              controller: controller,
              image: Image.file(imageFile),
            ),
          ),
        ),
        bottomNavigationBar: _buildButtons(),
      );

  Widget _buildButtons() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              controller.aspectRatio = 1.0;
              controller.crop = Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
            },
          ),
          IconButton(
            icon: Icon(Icons.aspect_ratio),
            onPressed: _aspectRatios,
          ),
          TextButton(
            onPressed: _finished,
            child: Text('Done'),
          ),
        ],
      );

  Future<void> _aspectRatios() async {
    final value = await showDialog<double>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select aspect ratio'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 1.0),
              child: Text('square'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 2.0),
              child: Text('2:1'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 4.0 / 3.0),
              child: Text('4:3'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 16.0 / 9.0),
              child: Text('16:9'),
            ),
          ],
        );
      },
    );
    if (value != null) {
      controller.aspectRatio = value;
      controller.crop = Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
    }
  }

  Future<void> _finished() async {
    var croppedImage = await controller.croppedImage();//final
    this.setState((){
      CroppedImage=croppedImage;
    });
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(6.0),
          titlePadding: EdgeInsets.all(8.0),
          title: Text('Cropped image'),
          children: [
            SizedBox(height: 5),
            croppedImage,
            TextButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>NextOpe()),
                );
              }, //Navigator.pop(context, true),
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('BACK'),
            ),
          ],
        );
      },
    );
  }
}

class NextOpe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TfliteHome(),
    );
  }
}

class TfliteHome extends StatefulWidget {
  @override
  _TfliteHomeState createState() => _TfliteHomeState();
}

class _TfliteHomeState extends State<TfliteHome> {
  String _model = ssd;
  File _image;

  double _imageWidth;
  double _imageHeight;
  bool _busy = false;

  List _recognitions;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        res = await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        );
      } else {
        res = await Tflite.loadModel(
          model: "assets/tflite/ssd_mobilenet.tflite",
          labels: "assets/tflite/ssd_mobilenet.txt",
        );
      }
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  selectFromImagePicker() async {
    var image = imageFile;
    if (image == null) return;
    setState(() {
      _busy = true;
    });
    predictImage(image);
  }

  predictImage(File image) async {
    if (image == null) return;

    if (_model == yolo) {
      await yolov2Tiny(image);
    } else {
      await ssdMobileNet(image);
    }

    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));

    setState(() {
      _image = image;
      _busy = false;
    });
  }

  yolov2Tiny(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  ssdMobileNet(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, numResultsPerClass: 1);

    setState(() {
      _recognitions = recognitions;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    Color blue = Colors.red;

    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: blue,
                width: 3,
              )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null ? Text("No Image Selected") : Image.file(_image),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    /*return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        tooltip: "Pick Image from gallery",
        onPressed: selectFromImagePicker,
      ),
      body: Stack(
        children: stackChildren,
      ),
    );*/
    return Scaffold(
      body: Stack(
        children: stackChildren,
      ),
      persistentFooterButtons: <Widget>[
        // ignore: deprecated_member_use
        RaisedButton(
          elevation: 10.0,
          onPressed: () {
            selectFromImagePicker();
          },
          color: Colors.green,
          child: Text("detect object"),
            //color: Colors.white,
          ),
        // ignore: deprecated_member_use
        RaisedButton(
          elevation: 10.0,
          onPressed: () {
            dragdrop();
          },
          color: Colors.blueGrey,
          child: Text("next"),
            //color: Colors.white,
          ),
      ],
    );
  }
}

class dragdrop {

}