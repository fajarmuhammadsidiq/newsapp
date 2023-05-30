import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/api/api_bloc.dart';
import 'package:news/model/headlines_model.dart';
import '../../bloc/travel/travel_news_bloc.dart';
import '../../controller/page_controller.dart';
import '../../router/route.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiBloc newbloc;

  late TravelNewsBloc newbloc2;

  IndexController controller = IndexController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newbloc = BlocProvider.of<ApiBloc>(context);
      final newbloc2 = BlocProvider.of<TravelNewsBloc>(context);
      newbloc.add(ApiEventHeadlines());
      newbloc2.add(ApiEventTravel());
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Good morning"),
                            SizedBox(height: 5),
                            Text("Sung 9 April,2023"),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.sunny,
                              size: 35,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 20),
                            Text("Sunny , 30C"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                BlocProvider(
                  create: (_) => newbloc,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: BlocListener<TravelNewsBloc, TravelNewsState>(
                      listener: (context, state) {
                        if (state is TravelNewsStateEror) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<TravelNewsBloc, TravelNewsState>(
                        builder: (context, state) {
                          if (state is TravelNewsStateInitial) {
                            return _buildLoading();
                          } else if (state is TravelNewsStateLoading) {
                            return _buildLoading();
                          } else if (state is TravelNewsStateCompleted) {
                            return buildCard(context, state.headlines);
                          } else if (state is TravelNewsStateEror) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                BlocProvider(
                  create: (_) => newbloc2,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: BlocListener<ApiBloc, ApiState>(
                      listener: (context, state) {
                        if (state is ApiStateEror) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<ApiBloc, ApiState>(
                        builder: (context, state) {
                          if (state is ApiStateInitial) {
                            return _buildLoading();
                          } else if (state is ApiStateLoading) {
                            return _buildLoading();
                          } else if (state is ApiStateCompleted) {
                            return buildCard(context, state.headlines);
                          } else if (state is ApiStateEror) {
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
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: controller.pageIndex,
        onTap: (int i) {
          setState(() {
            controller.changeIndexPage(i, context);
          });
          controller.changeIndexPage(i, context);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
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

  Widget buildCard(BuildContext context, Headlines model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.articles!.length,
        itemBuilder: (context, index) {
          final data = model.articles![index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.detailPage, arguments: data);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 250,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: "${data.urlToImage}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/Image.png",
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "${model.articles![index].title}",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
