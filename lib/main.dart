import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/quote_card.dart';
import 'package:window_size/window_size.dart';

import 'httpReqUtil.dart';
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
  List<Quote> quotes = [];
  HttpReqUtil httpUtils = HttpReqUtil();
  List<Widget> dispSongList() {
    List<Widget> dadax = quotes
        .map((quote) => QuoteWidget(
            quote: quote,
            delete: () {
              delList(quote.text);
            }))
        .toList();
    return dadax;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      httpUtils.postFile(file);
    } else {}
  }

  void getMyList() async {
    var result = await httpUtils.getList();
    String body = result.body;
    List<dynamic> tagsJson = jsonDecode(body);
    print(tagsJson.length);
    quotes.clear();
    for (int k = 0; k < tagsJson.length; k++) {
      quotes.add(Quote(text: tagsJson[k], author: ""));
    }
    setState(() {});
  }

  void delList(String s) async {
    var result = await httpUtils.deleteItem(s);
    String body = result.body;
    List<dynamic> tagsJson = jsonDecode(body);
    print(tagsJson.length);
    quotes.clear();
    for (int k = 0; k < tagsJson.length; k++) {
      quotes.add(Quote(text: tagsJson[k], author: ""));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyList();
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
            children: dispSongList(),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton.icon(
                onPressed: () {
                  pickFile();
                },
                icon: Icon(Icons.add),
                label: Text('添加歌曲')),
          )
        ],
      ),
    );
  }
}
