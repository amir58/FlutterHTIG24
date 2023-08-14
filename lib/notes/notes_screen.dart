import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/add_note_screen.dart';
import 'package:flutter24/notes/edit_note_screen.dart';
import 'package:flutter24/notes/login/page/notes_login_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // List<String> notes = ["Wake up at 7 am", "lecture at 10 am", "hello"];
  // 0 => "Wake up at 7 am"
  // 1 => "lecture at 10 am"
  // notes[1];

  List<Map<String, dynamic>> notes = [];

  // 0 =>{"userId": userId,"noteId": noteId,"note": note}
  // 1 =>{"userId": userId,"noteId": noteId,"note": note}
  // 2 =>{"userId": userId,"noteId": noteId,"note": note}
  // notes[1]['noteId']

  @override
  void initState() {
    super.initState();
    getNotesFromFirestore();
  }

  void getNotesFromFirestore() {
    String userId = auth.currentUser!.uid;
    print(userId);

    firestore
        .collection("notes")
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      // notes.addAll(value.docs.map((e) => e.data()).toList());
      notes.clear();
      for (var document in value.docs) {
        final note = document.data();
        notes.add(note);
      }
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesLoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddNoteScreen();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return noteItem(index);
        },
      ),
    );
  }

  Widget noteItem(int index) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(notes[index]['note']),
          ),
          IconButton(
            onPressed: () => navigateToEditNoteScreen(index),
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              firestore
                  .collection("notes")
                  .doc(notes[index]['noteId'])
                  .delete();
              notes.removeAt(index);
              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAddNoteScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNoteScreen(),
        )).then((value) {
      getNotesFromFirestore();
    });
  }

  void navigateToEditNoteScreen(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNoteScreen(
            note: notes[index],
          ),
        )).then((value) {
      getNotesFromFirestore();
    });
  }
}
