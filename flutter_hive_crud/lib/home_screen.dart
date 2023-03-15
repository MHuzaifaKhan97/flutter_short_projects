import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive CRUD")),
      body: Column(
        children: [
          FutureBuilder(
              future: Hive.openBox('todos'),
              builder: ((BuildContext context, AsyncSnapshot<Box> snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data?.get('name')),
                    Text(snapshot.data!.get('age').toString()),
                    Text(snapshot.data!.get('details').toString()),
                    Text(snapshot.data!.get('details')["lang"].toString()),
                    Text(snapshot.data!.get('details')["prog-lang"].toString()),
                  ],
                );
              }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('todos');
          box.put('name', "Muhammad Huzaifa Khan");
          box.put('age', 25);
          box.put('details', {
            "lang": ["English", "Urdu"],
            "prog-lang": ["Flutter", 'Dart', "Node", "React"]
          });
          print(box.get('name'));
          print(box.get('age'));
          print(box.get('details'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
