import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/widgets/midi_card.dart';

class MidiFileView extends StatefulWidget {
  const MidiFileView({super.key});

  @override
  State<MidiFileView> createState() => _MidiFileViewState();
}

class _MidiFileViewState extends State<MidiFileView> {
  @override
  Widget build(BuildContext context) {
    // Example list of MIDI file names
    final List<String> mp3FileNames = [
      "WeWereAngels",
      "Departure",
      "CruelThesis",
      "Binks",
      "Akatsuki",
      "BlueBird",
      "NeverGive",
      "ZeldaSea",
    ];

    // In case the names have spaces
    // final List<String> midiPaths = [
    //   "Black&Grey",
    //   "ClassicVibe",
    //   "JazzinParis",
    //   "SmoothKeys",
    //   "FunkyBeat",
    //   "FunkyBeat",
    //   "FunkyBeat",
    //   "FunkyBeat",
    // ];
    
    return ListView.builder(
      itemCount: mp3FileNames.length,
      itemBuilder: (BuildContext context, int index) {
        return MidiCard(mp3Name: mp3FileNames[index]);
      },
    );
  }
}
