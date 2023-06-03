import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news/ApiRepository/api_client.dart' as base;
import 'package:news/model/headlines_model.dart';

class ApiProvider {
  Future<Headlines> headlinesNews() async {
    try {
      var response = await http
          .get(Uri.parse(base.headlines), headers: {"X-Api-Key": base.apiKey});

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;

      return Headlines.fromJson(data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Headlines.withError("Data not found / Connection issue");
    }
  }

  Future<Headlines> travelNews() async {
    try {
      var response = await http
          .get(Uri.parse(base.travelNews), headers: {"X-Api-Key": base.apiKey});

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return Headlines.fromJson(data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Headlines.withError("Data not found / Connection issue");
    }
  }

  Future<Headlines> moreFromSource(String nameSource) async {
    String url =
        "https://newsapi.org/v2/everything?q=$nameSource&apiKey=73e3be62415b491c882fc52918a2c6f8";
    try {
      var response =
          await http.get(Uri.parse(url), headers: {"X-Api-Key": base.apiKey});

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return Headlines.fromJson(data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Headlines.withError("Data not found / Connection issue");
    }
  }

  Future<Headlines> exploreNews() async {
    try {
      var response = await http.get(Uri.parse(base.exploreNews),
          headers: {"X-Api-Key": base.apiKey});

      Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      print(data);
      return Headlines.fromJson(data);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return Headlines.withError("Data not found / Connection issue");
    }
  }
}
