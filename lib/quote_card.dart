import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/quote.dart';

class QuoteWidget extends StatelessWidget {
  final Quote quote;
  final Function delete;
  QuoteWidget({required this.quote, required this.delete});

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
            FlatButton.icon(
                onPressed: () {
                  delete();
                },
                icon: Icon(Icons.play_circle_fill),
                label: Text('播放'))
          ],
        ),
      ),
    );
  }
}
