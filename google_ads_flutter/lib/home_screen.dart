import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 4",
      "Item 5",
      "Item 6",
      "Item 7",
      "Item 8",
      "Item 9",
      "Item 10",
      "Item 11",
      "Item 12",
      "Item 13",
      "Item 14",
    ];
    return Scaffold(
      appBar: AppBar(title: Text("AdMob Ads Example")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              child: Text("Add will be placed here"),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: Text("Show Interstitial Ads")),
                ElevatedButton(
                    onPressed: () {}, child: Text("Show Rewarded Ads"))
              ],
            ),
            ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(list[index]),
                    leading: Icon(Icons.star),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
