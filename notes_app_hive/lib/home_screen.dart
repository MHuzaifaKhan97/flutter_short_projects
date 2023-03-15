import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_hive/boxes/boxes.dart';
import 'package:notes_app_hive/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var notes = box.values.toList().cast<NotesModel>();
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(notes[index].title),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                deleteNote(notes[index]);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                updateNote(notes[index]);
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(notes[index].description),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteNote(NotesModel note) async {
    await note.delete();
  }

  Future<void> updateNote(NotesModel note) {
    titleController.text = note.title;
    descController.text = note.description;
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Add Notes"),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Title"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Desscription"),
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    note.title = titleController.text;
                    note.description = descController.text;
                    note.save();
                    titleController.clear();
                    descController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Edit")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
            ],
          );
        }));
  }

  Future<void> _showDialog() {
    titleController.clear();
    descController.clear();
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("Add Notes"),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Title"),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Desscription"),
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titleController.clear();
                    descController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
            ],
          );
        }));
  }
}
