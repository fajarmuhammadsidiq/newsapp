import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/page_controller.dart';
import '../../widget/appbar_explore.dart';
import '../../widget/appbar_home.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  IndexController controller = IndexController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          AppbarExplore(),
          SizedBox(height: 10),
        ],
      )),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: 1,
        onTap: (int i) {
          controller.changeIndexPage(i, context);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
