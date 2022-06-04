import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/song.dart';

class SongWidget extends StatelessWidget {
  final Song song;
  final Function delete;
  final Function play;
  SongWidget({required this.song, required this.delete, required this.play});

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
            SizedBox(height: 6.0),
            Text(
              song.author,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      play();
                    },
                    icon: song.isPlay
                        ? Icon(Icons.pause_circle_filled)
                        : Icon(Icons.play_circle_fill),
                    label: song.isPlay ? Text('暂停') : Text('播放')),
                ElevatedButton.icon(
                    onPressed: () {
                      delete();
                    },
                    icon: Icon(Icons.delete),
                    label: Text('删除'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
