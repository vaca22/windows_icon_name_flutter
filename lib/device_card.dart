import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/audio_device.dart';

class DeviceWidget extends StatelessWidget {
  final AudioDevice song;

  DeviceWidget({required this.song});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              song.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
