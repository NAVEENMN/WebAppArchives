import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class Server {

  String ip = "52.39.96.192";
 
  // ex: resourceUrl: accounts, params: collection=Medteam&filter_by=id&id=m_1
  Future<dynamic> getData(String resourceUrl, String params) async {
    print("Http: Making a GET request");
    String url = "http://$ip/$resourceUrl?$params";
    http.Response data = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
    print("Http: Got response");
    return data;
  }

  // ex: resourceUrl: accounts, params: collection=Medteam&filter_by=id&id=m_1
  Future<dynamic> postData(String resourceUrl, var jsonPayload) async {
    print("Http: Making a POST request");
    print("Data");
    print(jsonPayload);
    String url = "http://$ip/$resourceUrl";

    http.Response data = await http.post(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
      body: jsonPayload,
    );
    print("Http: Got response");
    return data.body;
  }
}