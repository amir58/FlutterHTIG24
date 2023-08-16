part of 'notes_cubit.dart';

@immutable
abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class GetNotesSuccessState extends NotesStates {}

class GetNotesFailureState extends NotesStates {
  final String errorMessage;

  GetNotesFailureState(this.errorMessage);
}

class DeleteNoteSuccessState extends NotesStates {}

class DeleteNoteFailureState extends NotesStates {
  final String errorMessage;

  DeleteNoteFailureState(this.errorMessage);
}