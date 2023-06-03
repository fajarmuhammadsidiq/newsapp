import 'dart:ffi';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/headlines_model.dart';
import '../router/route.dart';

Widget buildCardExplore(BuildContext context, Headlines model) {
  final dataModel = model.articles!;

  var loopData = dataModel.map((e) {
    String defaultImage = "https://ui-avatars.com/api/?name=${e.author}}";

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.white,
            child: Row(children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                          maxLines: 2,
                          e.title.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(defaultImage),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              e.author.toString() != "null"
                                  ? e.author.toString()
                                  : "Anonymous",
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${e.urlToImage}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/Image.png", fit: BoxFit.cover),
                  ),
                ),
              ),
            ])));
  }).toList();
  var randomData = Random().nextInt(dataModel.length);
  String defaultImage =
      "https://ui-avatars.com/api/?name=${dataModel[randomData].author}}";
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: ListView(
      children: [
        Container(
            height: 380,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "${dataModel[randomData].urlToImage}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/Image.png", fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                  maxLines: 2,
                  dataModel[randomData].title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(defaultImage),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataModel[randomData].author != "null"
                              ? dataModel[randomData].author.toString()
                              : "Anonymous",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            DateFormat.yMMMEd().format(DateTime.parse(
                                dataModel[randomData].publishedAt.toString())),
                            style: const TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])),
        SizedBox(
          height: 10,
        ),
        ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: loopData,
        )
      ],
    ),
  );
}
