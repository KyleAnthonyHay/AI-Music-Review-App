import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:music_app/widgets/review_card.dart';
import 'package:http/http.dart' as http;

class ReviewsView extends StatefulWidget {
  final String mp3Name;
  const ReviewsView({super.key, required this.mp3Name});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  List<dynamic> reviews = [];

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      // Assuming sendPostRequest returns a JSON string.
      String data = await sendPostRequest(widget.mp3Name);
      setState(() {
        reviews = json.decode(data);
      });
    } catch (e) {
      // Handle potential errors like decoding failures or bad data
      print('Error loading reviews: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Removed Scaffold and simplified to just the necessary content
    if (reviews.isEmpty) {
      return Center(child: const Text("No Reviews Yet"));
    } else {
      return ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return ReviewCard(
            ReviewerName: review['midiName'],
            ReviewTitle: review['title'],
            Review: review['description'],
            ReviewRating: review['rating'],
          );
        },
      );
    }
  }
}

Future<String> sendPostRequest(String message) async {
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
    return response.body;
  } catch (e) {
    print("Error occurred: $e");
    return "Error";
  }
}
