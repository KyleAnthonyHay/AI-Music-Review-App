import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/music_player_page.dart';
import 'package:music_app/pages/reviews_page.dart';

class MidiCard extends StatefulWidget {
  const MidiCard({super.key, required this.mp3Name});
  final String mp3Name;
  // variable to play midi file(possibly a file path)

  @override
  State<MidiCard> createState() => _MidiCardState();
}

class _MidiCardState extends State<MidiCard> {
  @override
  Widget build(BuildContext context) {
    String listIcon =
        'assets/images/list-icon.png'; // Icon for viewing details or reviews
    String playIcon =
        'assets/images/play-icon.png'; // Icon for playing the mp3

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.all(10.0),
      width: 320,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFC71391)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.mp3Name),
          Row(
            children: [
              IconButton(
                icon: Image.asset(playIcon, width: 20, height: 20),
                onPressed: () {
                  print("Play MP3 button pressed");
                  // Navigate and pass the midiName to the MusicPlayerPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MusicPlayerPage(mp3Name: widget.mp3Name),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Image.asset(listIcon, width: 20, height: 20),
                onPressed: () {
                  print("View Reviews button pressed");
                  // Navigate to reviews page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReviewsPage(mp3Name: widget.mp3Name)),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
