import 'package:flutter/material.dart';

class AppbarContainer extends StatelessWidget {
  const AppbarContainer({
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
    );
  }
}
