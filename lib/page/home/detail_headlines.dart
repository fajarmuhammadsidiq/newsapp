import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:news/bloc/sourceNews/source_news_bloc.dart';

import '../../model/headlines_model.dart';
import '../../widget/card_state.dart';
import '../../widget/loading_state.dart';

class detailHeadlinesNewsPage extends StatefulWidget {
  detailHeadlinesNewsPage({super.key});

  @override
  State<detailHeadlinesNewsPage> createState() =>
      _detailHeadlinesNewsPageState();
}

class _detailHeadlinesNewsPageState extends State<detailHeadlinesNewsPage> {
  late SourceNewsBloc newsBloc = SourceNewsBloc();

  @override
  Widget build(BuildContext context) {
    Article? data = ModalRoute.of(context)!.settings.arguments as Article?;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsBloc = BlocProvider.of<SourceNewsBloc>(context);
    });
    newsBloc.add(ApiNewsEvent(name: data!.source!.name.toString()));
    String defaultImage = "https://ui-avatars.com/api/?name=${data.author}}";

    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.amber,
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                color: Colors.transparent,
                child: CachedNetworkImage(
                  imageUrl: "${data.urlToImage}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/Image.png", fit: BoxFit.cover),
                ),
              ),
              ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    color: Colors.transparent,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            data.title.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(defaultImage),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.author.toString() != "null"
                                          ? data.author.toString()
                                          : "Anonymous",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat.yMMMEd().format(
                                              DateTime.parse(
                                                  data.publishedAt.toString())),
                                          style: const TextStyle(),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            data.source!.name.toString(),
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.justify,
                            data.description.toString(),
                            style: const TextStyle(),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.start,
                            "More from " + data.source!.name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          BlocProvider(
                            create: (_) => newsBloc,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child:
                                  BlocListener<SourceNewsBloc, SourceNewsState>(
                                listener: (context, state) {
                                  if (state is SourceNewsStateError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.errorMessage),
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<SourceNewsBloc,
                                    SourceNewsState>(
                                  builder: (context, state) {
                                    if (state is SourceNewsStateInitial) {
                                      return buildLoading();
                                    } else if (state
                                        is SourceNewsStateLoading) {
                                      return buildLoading();
                                    } else if (state
                                        is SourceNewsStateCompleted) {
                                      return buildCardDetail(
                                          context, state.headlines);
                                    } else if (state is SourceNewsStateError) {
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
                ],
              ),
              Positioned(
                  left: 10,
                  top: 50,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: BackButton(color: Colors.black))),
            ])));
  }
}
