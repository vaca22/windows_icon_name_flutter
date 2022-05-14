import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/quote_card.dart';
import 'package:window_size/window_size.dart';

import 'quote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(400, 300));
    setWindowMaxSize(Size.infinite);
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("网络音频"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: quotes
            .map((quote) => QuoteWidget(
                quote: quote,
                delete: () {
                  setState(() {
                    quotes.remove(quote);
                  });
                }))
            .toList(),
      ),
    );
  }
}
