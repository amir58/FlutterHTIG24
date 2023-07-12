import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Map<String, dynamic> note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final firestore = FirebaseFirestore.instance;

  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noteController.text = widget.note['note'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  addNote();
                },
                child: const Text(
                  "Update",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNote() {
    String note = noteController.text;

    Map<String, dynamic> data = {
      "note": note,
    };

    firestore
        .collection("notes")
        .doc(widget.note['noteId'])
        .update(data)
        .then((value ) {
      Navigator.pop(context);
    }).catchError((error) {
      print(error);
    });
  }
}
