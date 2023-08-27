import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter24/notes/add_note/cubit/add_note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final noteController = TextEditingController();

  final cubit = AddNoteCubit();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<AddNoteCubit, AddNoteStates>(
        listener: (context, state) => onStateChanged(state),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Note"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: "Note",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Note required";
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addNote(note: noteController.text);
                        }
                      },
                      child: const Text(
                        "Add",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onStateChanged(AddNoteStates state) {
    if (state is AddNoteSuccessState) {
      onAddNoteSuccess();
    }
    if (state is AddNoteFailureState) {
      onAddNoteFailure(state.errorMessage);
    }
  }

  void onAddNoteSuccess() => Navigator.pop(context);

  void onAddNoteFailure(String errorMessage) =>
      Fluttertoast.showToast(msg: errorMessage);
}

