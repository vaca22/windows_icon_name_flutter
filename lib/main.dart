import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_file_list_flutter/portscanner.dart';
import 'package:http_file_list_flutter/song_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';

import 'httpReqUtil.dart';
import 'song.dart';

void setIp(String ip) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('ip', ip);
}

void getIp() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'counter' key. If it doesn't exist, returns null.
  final String? counter = prefs.getString('ip');
  if (counter != null) {
    print("" + counter.toString());
    HttpReqUtil.baseAddr = counter;
  }
}

List<String> ips = [];
RawDatagramSocket? mySocket;

Future printIps() async {
  ips.clear();
  for (var interface in await NetworkInterface.list()) {
    for (var addr in interface.addresses) {
      final n = addr.address;
      final a = n.lastIndexOf(".");
      final b = n.substring(0, a + 1);
      print('guck1 ${a} ${n}   ${b}');
      ips.add(b + "0/24");
    }
  }
}

final scanner = Scanner();
Future scanTcp() {
  List<String> foundPorts = [];
  List<Future> connectionFutures = [];
  for (var ip in ips) {
    connectionFutures.add(scanner.scanPortRange(ip).then((result) {
      foundPorts.addAll(result);
    }));
  }

  Completer completer = new Completer();
  Future.wait(connectionFutures).then((allSockets) {
    completer.complete(foundPorts);
  });
  return completer.future;
}

void main() {
  getIp();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('网络音频');
    setWindowMinSize(const Size(1000, 700));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());

  int port = 8082;
  RawDatagramSocket.bind(InternetAddress.anyIPv4, port).then((socket) {
    mySocket = socket;
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? dg = socket.receive();
        if (dg == null) return;
        final recvd = String.fromCharCodes(dg.data);
        if (recvd.startsWith("xvacax"))
          print("$recvd from ${dg.address.address}:${dg.port}");
      }
    });
    // socket.send(
    //     Utf8Codec().encode("vaca"), InternetAddress("192.168.6.109"), 8889);
  });
  printIps();
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
  List<Song> song = [];
  HttpReqUtil httpUtils = HttpReqUtil();

  List<Widget> dispSongList() {
    List<Widget> result = song
        .map((quote) => SongWidget(
              song: quote,
              delete: () {
                delList(quote.text);
              },
              play: () {
                playList(quote.text, quote.isPlay);
              },
            ))
        .toList();
    return result;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await HttpReqUtil.fileUpload(file);
      getMyList();
    }
  }

  void getMyList() async {
    var result = await httpUtils.getList();
    String body = utf8.decode(result.bodyBytes);
    print(body);
    List<dynamic> tagsJson = jsonDecode(body);
    print(tagsJson.length);
    song.clear();
    for (int k = 0; k < tagsJson.length; k++) {
      song.add(Song(text: tagsJson[k], author: ""));
    }
    setState(() {});
  }

  void delList(String s) async {
    var result = await httpUtils.deleteItem(s);
    String body = utf8.decode(result.bodyBytes);
    List<dynamic> tagsJson = jsonDecode(body);
    print(tagsJson.length);
    song.clear();
    for (int k = 0; k < tagsJson.length; k++) {
      song.add(Song(text: tagsJson[k], author: ""));
    }
    setState(() {});
  }

  void playList(String s, bool isPlay) async {
    if (isPlay) {
      var result = await httpUtils.pauseItem(s);
      String body = utf8.decode(result.bodyBytes);
      List<dynamic> tagsJson = jsonDecode(body);
      print(tagsJson.length);
      song.clear();
      for (int k = 0; k < tagsJson.length; k++) {
        song.add(Song(text: tagsJson[k], author: "", isPlay: false));
      }
    } else {
      var result = await httpUtils.playItem(s);
      String body = utf8.decode(result.bodyBytes);
      List<dynamic> tagsJson = jsonDecode(body);
      print(tagsJson.length);
      song.clear();
      for (int k = 0; k < tagsJson.length; k++) {
        if (tagsJson[k] == s) {
          song.add(Song(text: tagsJson[k], author: "", isPlay: true));
        } else {
          song.add(Song(text: tagsJson[k], author: "", isPlay: false));
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = HttpReqUtil.baseAddr;
    getMyList();
  }

  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300,
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton.icon(
                              onPressed: () {
                                scanTcp().then((value) => print(value));
                              },
                              icon: Icon(Icons.search),
                              label: Text('扫描设备')),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: ListView(
                  children: dispSongList(),
                )),
              ],
            ),
          ),
          SizedBox(
            width: 350,
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    TextField(
                      enabled: false,
                      autofocus: true,
                      controller: _controller,
                      decoration: const InputDecoration(
                          labelText: "IP地址",
                          hintText: "输入ip地址",
                          prefixIcon: Icon(Icons.network_wifi)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton.icon(
                              onPressed: () {
                                getMyList();
                              },
                              icon: Icon(Icons.refresh),
                              label: Text('刷新')),
                        ],
                      ),
                    )
                  ],
                ),
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
          ),
        ],
      ),
    );
  }
}
