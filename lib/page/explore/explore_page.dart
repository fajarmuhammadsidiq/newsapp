import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../bloc/exploreNews/explore_news_bloc.dart';
import '../../controller/page_controller.dart';
import '../../widget/appbar_explore.dart';
import '../../widget/build_card_detailPage.dart';
import '../../widget/build_card_explore.dart';
import '../../widget/loading_state.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  IndexController controller = IndexController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            AppbarExplore(),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            BlocProvider<ExploreNewsBloc>(
              create: (_) => ExploreNewsBloc()..add(ApiExploreNewsEvent()),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: BlocListener<ExploreNewsBloc, ExploreNewsState>(
                  listener: (context, state) {
                    if (state is ExploreNewsStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ExploreNewsBloc, ExploreNewsState>(
                    builder: (context, state) {
                      if (state is ExploreNewsStateInitial) {
                        return buildLoading();
                      } else if (state is ExploreNewsStateLoading) {
                        return buildLoading();
                      } else if (state is ExploreNewsStateCompleted) {
                        return buildCardExplore(context, state.headlines);
                      } else if (state is ExploreNewsStateError) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
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
            icon: Icon(Icons.blur_circular_sharp),
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
