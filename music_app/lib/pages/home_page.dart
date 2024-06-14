// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/sections/midi_file_view.dart';
import 'package:music_app/widgets/greeting_area.dart';
import 'package:music_app/widgets/upload_area.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/sections/midi_file_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false; // Track play/pause state
  //User? user = FirebaseAuth.instance.currentUser; // For later, try to get the user's icon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title:
            Text("Rate all MP3 files", style: TextStyle(color: Colors.black)),
        centerTitle:
            true, // Set centerTitle to false to align the title naturally to the start
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            FirebaseAuth.instance.signOut(); // Sign out functionality
            Navigator.pushReplacementNamed(context, "/");
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                "MP3 Files",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "View our top generated MP3 Files below",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: 10),
              Expanded(child: MidiFileView()), //This says midi but it's really mp3s
            ],
          ),
        ),
      ),
    );
  }
}
