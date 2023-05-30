import 'package:flutter/material.dart';
import 'package:news/page/explore/explore_page.dart';
import 'package:news/page/home/detail_headlines.dart';
import 'package:news/page/home/home_page.dart';
import 'package:news/page/profile/profile_page.dart';

import '../page/favorite/favorite_page.dart';

class Routes {
  static const String home = '/';
  static const String detailPage = '/detailPage';
  static const String TestApi = "/testapi";
  static const String detailHeadlinesNews = "/detailPage";
  static const String favorite = "/favorite";
  static const String explore = "/explore";
  static const String profile = "/profile";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomePage(),
      detailPage: (context) => detailHeadlinesNewsPage(),
      favorite: (context) => FavoritePage(),
      explore: (context) => ExplorePage(),
      profile: (context) => ProfilePage(),
    };
  }
}
