import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final noteController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
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
                  "Add",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNote() {
    String userId = auth.currentUser!.uid;

    String note = noteController.text;

    String noteId = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> data = {
      "userId": userId,
      "noteId": noteId,
      "note": note
    };

    firestore.collection("notes").doc(noteId).set(data);

    Navigator.pop(context, note);
  }
}
