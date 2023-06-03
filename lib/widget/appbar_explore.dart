import 'package:flutter/material.dart';

class AppbarExplore extends StatelessWidget {
  const AppbarExplore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explore",
              style: TextStyle(
                  fontSize: 24, letterSpacing: 10, color: Colors.grey[600]),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                size: 20,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
