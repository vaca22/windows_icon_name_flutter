import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/audio_device.dart';

class DeviceWidget extends StatelessWidget {
  final AudioDevice song;
  final Function play;
  DeviceWidget({required this.song, required this.play});

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
              "设备ip: " + song.text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            FlatButton.icon(
                onPressed: () {
                  play();
                },
                icon: Icon(Icons.select_all),
                label: Text('查看详情')),
          ],
        ),
      ),
    );
  }
}
