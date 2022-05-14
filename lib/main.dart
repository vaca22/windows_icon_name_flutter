import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/quote_card.dart';
import 'package:window_size/window_size.dart';

import 'quote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('好吃');
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

  List<Widget> dada() {
    List<Widget> dadax = quotes
        .map((quote) => QuoteWidget(
            quote: quote,
            delete: () {
              setState(() {
                quotes.remove(quote);
              });
            }))
        .toList();
    return dadax;
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
        children: [
          Expanded(
              child: ListView(
            children: dada(),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton.icon(
                onPressed: () {
                  // delete();
                },
                icon: Icon(Icons.add),
                label: Text('添加歌曲')),
          )
        ],
      ),
    );
  }
}
