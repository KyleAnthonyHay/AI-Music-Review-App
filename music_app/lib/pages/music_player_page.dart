import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:music_app/pages/leave_review_page.dart';

class MusicPlayerPage extends StatefulWidget {
  final String mp3Name;
  const MusicPlayerPage({super.key, required this.mp3Name});

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        // Assuming mp3 playback is initialized here or another method is used
        startMusic();
      } else {
        audioPlayer.pause();
      }
    });
  }

  Future<void> startMusic() async {
    // Initialize mp3 playback
    await audioPlayer.play(AssetSource("mp3/${widget.mp3Name}.mp3"));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String coverArtIcon = 'assets/images/song-cover-art.png';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text("View MP3 Files"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(coverArtIcon, width: 300, height: 300),
            Text(
              widget.mp3Name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 30,
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30, color: Colors.black),
                    onPressed: togglePlayPause,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC71391),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReviewPage(mp3Name: widget.mp3Name)),
                );
              },
              child: Text('Leave a Review'),
            ),
          ],
        ),
      ),
    );
  }
}
