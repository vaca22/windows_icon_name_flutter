import 'package:flutter/material.dart';

import 'quote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const vaca(),
    );
  }
}

class vaca extends StatefulWidget {
  const vaca({Key? key}) : super(key: key);

  @override
  State<vaca> createState() => _vacaState();
}

class _vacaState extends State<vaca> {
  List<Quote> quotes = [
    Quote(text: "fuckgfgdfsgfsdfgsdfgdsfdg1", author: "fuck2"),
    Quote(text: "asdsdfgsdfgdsdfgdsfgsfgdsfgf", author: "fdasa"),
    Quote(text: "qwedsfgsdfgfddfsgdsfgsgxdfgr", author: "rewq"),
    Quote(text: "zxcdsfgdsfgsdfdsfgsfdgdfggdsfv", author: "vczxz"),
  ];

  Widget dada(quote) {
    return QuoteWidget(
      quote: quote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("网络音频"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => dada(quote)).toList(),
      ),
    );
  }
}

class QuoteWidget extends StatelessWidget {
  Quote quote;
  QuoteWidget({required this.quote});

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
            )
          ],
        ),
      ),
    );
  }
}
