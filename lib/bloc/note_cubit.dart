import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/model/note_model.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  static NoteCubit get(context)=>BlocProvider.of(context);

  var titleController=TextEditingController();
  var noteController=TextEditingController();
  Stream? noteStream;
  Note? note;
  var noteRef=FirebaseFirestore.instance.collection('note');

  var formKey = GlobalKey<FormState>();
  voidSave(String noteTitle, String noteText)
  {
    var noteRef=FirebaseFirestore.instance.collection('note');
    formKey.currentState?.save();
    emit(NoteSaveLoadingState());
    Note note =Note( noteTitle: noteTitle, noteText: noteText);
    noteRef.add(note.toMap());
    emit(NoteSaveErrorState());
  }

   voidEdit(String id, Note note)
     async {
       emit(NoteEditLoadingState());
       await noteRef.doc(id).update(note.toMap()).then((value)
       {
         emit(NoteEditSuccessState());
       }).catchError((error)
       {
         if (kDebugMode) {
           print("errror ${error.toString()}");
         }
         emit(NoteEditErrorState());
       });
     }

  voidDelete(String id)
  async {
    emit(NoteDeleteLoadingState());
    await noteRef.doc(id).delete().then((value)
    {
      emit(NoteDeleteSuccessState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print("errror ${error.toString()}");
      }
      emit(NoteDeleteErrorState());
    });
  }

}
