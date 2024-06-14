import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/sections/reviews_view.dart';
import 'package:music_app/widgets/review_card.dart';
import 'package:http/http.dart' as http;

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key, required this.mp3Name});
  final String mp3Name;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    sendPostRequest('${widget.mp3Name}'); //Testing function

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mp3Name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/");
          },
        ),
        backgroundColor: Colors.white, // Match other pages' style
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Reviews:",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: ReviewsView(mp3Name: widget.mp3Name)),
          ],
        ),
      ),
    );
  }
}

//Testing function - you probably want to have this return some kind of data
Future<void> sendPostRequest(String message) async {
  final url =
      Uri.parse('https://deepmusic-app-zsjer2olsq-uc.a.run.app/matching-midi');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'text/plain'},
      body: message,
    );

    // Assuming you want to print the response body here
    print(response.body);
  } catch (e) {
    print("Error occurred: $e");
  }
}
