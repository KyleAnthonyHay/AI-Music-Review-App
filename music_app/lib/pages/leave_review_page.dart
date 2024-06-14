// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'reviews_page.dart';
import 'dart:math';

class ReviewPage extends StatefulWidget {
  final String mp3Name;
  const ReviewPage({super.key, required this.mp3Name});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 4; // Default rating is 4 stars
  bool _recommend = false; // State for the switch
  int random = Random().nextInt(999999); //for id
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mp3Name),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          //if this causes an issue with flutter and it being pushed/popped, you can comment it out
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Navigate back to the previous screen (right now there isn't one so it'll crash)
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Hide keyboard when tapped elsewhere on the screen
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'Your Rating:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Review Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Write description here...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 100),

              // ********** Recomendation Section Button ********** Commented out
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'Would you recommend?',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Checkbox(
              //       value: _recommend,
              //       checkColor: Colors.white,
              //       activeColor: Color(0xFFC71391),
              //       onChanged: (bool? value) {
              //         if (value != null) {
              //           setState(() {
              //             _recommend = value;
              //           });
              //         }
              //       },
              //     ),
              //   ],
              // ),
              // ********** Submit Button **********
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC71391),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                    shape: RoundedRectangleBorder(
                      // Add this line
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the border radius as needed
                    ),
                  ),
                  onPressed: () async {
                    //later this will submit data to server
                    // Use the state here (later remove the prints)
                    final url = Uri.parse(
                        'https://deepmusic-app-zsjer2olsq-uc.a.run.app/insert-entry'); // Replace with your server URL
                    try {
                      String? userName = "Unknown";
                      if (user != null) {
                        // Check if the user's name is available
                        String? userName = user!.displayName;
                      }
                      String descriptionWithoutCommas =
                          _descriptionController.text.replaceAll(',', '');
                      String titleWithoutCommas =
                          _titleController.text.replaceAll(',', '');

                      //POSTING
                      final response = await http.post(
                        url,
                        headers: {'Content-Type': 'text/plain'},
                        body:
                            '$random,${widget.mp3Name},$userName,$titleWithoutCommas,$descriptionWithoutCommas,$_rating',
                      );
                    } catch (e) {
                      print('error');
                    }
                    // print('Rating: $_rating');
                    // print('Title: ${_titleController.text}');
                    // print('Description: ${_descriptionController.text}');
                    // print('Recommend: $_recommend');
                    //Redirect
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ReviewsPage(mp3Name: widget.mp3Name)),
                      (route) => false,
                    );
                  },
                  child: Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
