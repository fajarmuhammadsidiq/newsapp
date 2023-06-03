import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/headlines_model.dart';
import '../router/route.dart';

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
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/Image.png", fit: BoxFit.cover),
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
