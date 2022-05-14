import 'dart:io';

import 'package:http/http.dart' as http;

class HttpReqUtil {
  Future<http.Response> postFile(File f) async {
    var url = Uri.parse('http://192.168.6.106/upload/good.mp3');
    var response = await http.post(url, body: f.readAsBytesSync());
    return response;
  }

  Future<http.Response> getList() async {
    var url = Uri.parse('http://192.168.6.106/');
    var response = await http.get(url);
    return response;
  }
}
