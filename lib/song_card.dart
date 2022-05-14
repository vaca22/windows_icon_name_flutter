import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/song.dart';

class SongWidget extends StatelessWidget {
  final Song quote;
  final Function delete;
  final Function play;
  SongWidget({required this.quote, required this.delete, required this.play});

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
              quote.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              quote.author,
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
                FlatButton.icon(
                    onPressed: () {
                      play();
                    },
                    icon: Icon(Icons.play_circle_fill),
                    label: Text('播放')),
                FlatButton.icon(
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
