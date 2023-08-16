import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteStates> {
  AddNoteCubit() : super(AddNoteInitialState());

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void addNote({required String note}) {
    String userId = auth.currentUser!.uid;

    String noteId = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, dynamic> data = {
      "userId": userId,
      "noteId": noteId,
      "note": note
    };

    firestore.collection("notes").doc(noteId).set(data);

    emit(AddNoteSuccessState());
  }
}
