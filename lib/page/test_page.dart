import 'package:flutter/material.dart';

import '../resources/api_repository.dart';

class TestApi extends StatelessWidget {
  TestApi({super.key});
  ApiRepository api = ApiRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("tester api"),
        ),
        body: FutureBuilder(
          future: api.fetchMoreSource("Washington Post"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.articles![index];
                  return ListTile(
                    title: Text(data.title.toString()),
                  );
                },
              );
            }
          },
        ));
  }
}
