import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _volume = 0.5;
  int _batteryLevel = 0;
  List<File> images = [];

  final Battery _battery = Battery();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getBatteryLevel();
    VolumeController().getVolume().then((value) {
      setState(() {
        _volume = value;
      });
    });
  }

  // 📱 Change Orientation
  void setPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // 🔋 Battery
  Future<void> getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }

  // 🔊 Volume
  void increaseVolume() {
    _volume += 0.1;
    if (_volume > 1.0) _volume = 1.0;
    VolumeController().setVolume(_volume);
    setState(() {});
  }

  void decreaseVolume() {
    _volume -= 0.1;
    if (_volume < 0.0) _volume = 0.0;
    VolumeController().setVolume(_volume);
    setState(() {});
  }

  // 🖼️ Pick Images
  Future<void> pickImages() async {
    final List<XFile>? pickedFiles =
        await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        images = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Feature App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Orientation
            Text("Screen Orientation", style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: setPortrait,
                  child: Text("Portrait"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: setLandscape,
                  child: Text("Landscape"),
                ),
              ],
            ),

            Divider(),

            // Volume
            Text("Volume Control: ${(_volume * 100).toInt()}%"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.volume_down),
                  onPressed: decreaseVolume,
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: increaseVolume,
                ),
              ],
            ),

            Divider(),

            // Battery
            Text("Battery Level: $_batteryLevel%"),
            ElevatedButton(
              onPressed: getBatteryLevel,
              child: Text("Refresh Battery"),
            ),

            Divider(),

            // Gallery Images
            ElevatedButton(
              onPressed: pickImages,
              child: Text("Select Images from Gallery"),
            ),

            SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.file(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Image ${index + 1}"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
