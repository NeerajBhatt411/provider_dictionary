import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<dynamic> getDictionary(String word) async {
    try {
      var response = await http.get(
          Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/${word}"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
