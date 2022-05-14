import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class HttpReqUtil {
  Future<http.Response> postFile(File f) async {
    String name = basename(f.path);
    var url = Uri.parse('http://192.168.6.106/upload/' + name);
    var response = await http.post(url, body: f.readAsBytesSync());
    return response;
  }

  Future<http.Response> getList() async {
    var url = Uri.parse('http://192.168.6.106/');
    var response = await http.get(url);
    return response;
  }
}
