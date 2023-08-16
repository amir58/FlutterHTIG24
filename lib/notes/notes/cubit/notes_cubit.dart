import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> notes = [];

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
      // setState(() {}); => refresh ui
      emit(GetNotesSuccessState());
    }).catchError((error) {
      emit(GetNotesFailureState(error.toString()));
    });
  }

  deleteNote(int index) {
    firestore
        .collection("notes")
        .doc(notes[index]['noteId'])
        .delete()
        .then((value) {
      notes.removeAt(index);
      emit(DeleteNoteSuccessState());
    }).catchError((error) {
      emit(DeleteNoteFailureState(error.toString()));
    });
    // setState(() {});
  }
}
