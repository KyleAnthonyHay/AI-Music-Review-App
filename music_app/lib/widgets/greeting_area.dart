import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GreetingArea extends StatefulWidget {
  const GreetingArea({super.key});

  @override
  State<GreetingArea> createState() => _GreetingAreaState();
}

class _GreetingAreaState extends State<GreetingArea> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Hello,',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'User!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
