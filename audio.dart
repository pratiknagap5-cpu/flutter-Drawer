import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaScreen(),
    );
  }
}

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(
      'assets/video/sample.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
  }

  // Audio Controls
  void playAudio() async {
    await _audioPlayer.play(AssetSource('audio/song.mp3'));
  }

  void stopAudio() async {
    await _audioPlayer.stop();
  }

  // Video Controls
  void playVideo() {
    _videoController.play();
  }

  void pauseVideo() {
    _videoController.pause();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio & Video Player"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            // AUDIO SECTION
            Text("Audio Player", style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: playAudio,
                  child: Text("Play"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopAudio,
                  child: Text("Stop"),
                ),
              ],
            ),

            SizedBox(height: 30),

            // VIDEO SECTION
            Text("Video Player", style: TextStyle(fontSize: 20)),

            _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : CircularProgressIndicator(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: playVideo,
                  child: Text("Play"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: pauseVideo,
                  child: Text("Pause"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
