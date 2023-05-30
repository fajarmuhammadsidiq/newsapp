import 'package:flutter/material.dart';

import '../router/route.dart';

class IndexController {
  int pageIndex = 0;

  void changeIndexPage(int i, context) {
    switch (i) {
      case 0:
        pageIndex = i;
        Navigator.pushReplacementNamed(context, Routes.home);
        break;
      case 1:
        pageIndex = i;
        Navigator.pushReplacementNamed(context, Routes.explore);
        break;
      case 2:
        pageIndex = i;
        Navigator.pushReplacementNamed(context, Routes.favorite);
        break;
      case 3:
        pageIndex = i;
        print("profile");
        Navigator.pushReplacementNamed(context, Routes.profile);
        break;
      default:
    }
  }
}
