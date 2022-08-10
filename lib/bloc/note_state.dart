part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

//save
class NoteSaveLoadingState extends NoteState {}
class NoteSaveSuccessState extends NoteState {}
class NoteSaveErrorState extends NoteState {}

//edit
 class NoteEditLoadingState extends NoteState {}
 class NoteEditSuccessState extends NoteState {}
 class NoteEditErrorState extends NoteState {}

 //delete
 class NoteDeleteLoadingState extends NoteState {}
 class NoteDeleteSuccessState extends NoteState {}
 class NoteDeleteErrorState extends NoteState {}

