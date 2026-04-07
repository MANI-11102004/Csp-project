import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String topic;
  const VideoPlayerWidget({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Video tutorial for: $topic",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
