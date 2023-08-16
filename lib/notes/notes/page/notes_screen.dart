import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/add_note/page/add_note_screen.dart';
import 'package:flutter24/notes/edit_note_screen.dart';
import 'package:flutter24/notes/login/page/notes_login_screen.dart';
import 'package:flutter24/notes/notes/cubit/notes_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesScreen extends StatefulWidget {
  NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final cubit = NotesCubit();

  @override
  void initState() {
    super.initState();
    cubit.getNotesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<NotesCubit, NotesStates>(
        listener: (context, state) {
          if (state is GetNotesFailureState) {
            onGetNoteFailure(state.errorMessage);
          }
          if (state is DeleteNoteFailureState) {
            onDeleteNoteFailure(state.errorMessage);
          }
        },
        child: Scaffold(
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
          body: BlocBuilder<NotesCubit, NotesStates>(
            buildWhen: (previous, current) {
              return current is GetNotesSuccessState ||
                  current is DeleteNoteSuccessState;
            },
            builder: (context, state) {
              return ListView.builder(
                itemCount: cubit.notes.length,
                itemBuilder: (context, index) {
                  return noteItem(index);
                },
              );
            },
          ),
        ),
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
            child: Text(cubit.notes[index]['note']),
          ),
          IconButton(
            onPressed: () => navigateToEditNoteScreen(index),
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () => cubit.deleteNote(index),
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
      cubit.getNotesFromFirestore();
    });
  }

  void navigateToEditNoteScreen(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNoteScreen(
            note: cubit.notes[index],
          ),
        )).then((value) {
      cubit.getNotesFromFirestore();
    });
  }

  void onGetNoteFailure(String errorMessage) =>
      Fluttertoast.showToast(msg: errorMessage);

  void onDeleteNoteFailure(String errorMessage) =>
      Fluttertoast.showToast(msg: errorMessage);
}
