import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1:2000';

class BaseClient
{
  var client = http.Client();

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);

    var response = await client.post(url, body: _payload);
    debugPrint(response.body);
    return response.body;
  }
  
  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);

    var response = await client.delete(url);
    debugPrint(response.body);
    return response.body;
  }
}