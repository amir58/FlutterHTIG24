import 'package:flutter/material.dart';
import 'package:flutter24/notes/add_note_screen.dart';
import 'package:flutter24/notes/edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = ["Wake up at 7 am", "lecture at 10 am", "hello"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
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
            child: Text(notes[index]),
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
      print('THEN => $value');
      if (value == null) return;
      notes.add(value);
      setState(() {});
    });
  }

  void navigateToEditNoteScreen(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNoteScreen(note: notes[index],),
        )).then((value) {
      print('THEN => $value');
      if (value == null) return;
      // notes.add(value);
      notes[index] = value;
      setState(() {});
    });
  }
}
