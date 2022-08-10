import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_cubit.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/utlis/naviagtion.dart';
import 'package:noteapp/views/home_screen.dart';

class UpDateScreen extends StatefulWidget {
  const UpDateScreen({Key? key, required this.noteId, required this.noteObj}) : super(key: key);
  final String noteId;
  final Note noteObj;

  @override
  State<UpDateScreen> createState() => _UpDateScreenState();
}

class _UpDateScreenState extends State<UpDateScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController noteController=TextEditingController();

  @override
  void initState() {
    noteController.text = widget.noteObj.noteText;
    titleController.text = widget.noteObj.noteTitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=NoteCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
            title: const Text('Edit Your Task'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    onChanged: (value)
                    {
                      cubit.titleController.text=value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: noteController,
                    onChanged: (value)
                    {
                      cubit.noteController.text=value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Type Your Note Here ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Note must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: ()
                    async
                    {
                      await cubit.voidEdit(widget.noteId, Note(noteTitle: titleController.text, noteText: noteController.text));
                      AppNavigator.customNavigator(
                        context: context,
                        screen: const HomeScreen(),
                        finish: false,
                      );
                    },
                    child: const Text('Edit ',
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: ()
                    async
                    {
                      await cubit.voidDelete(widget.noteId,);
                      AppNavigator.customNavigator(
                        context: context,
                        screen: const HomeScreen(),
                        finish: false,
                      );
                    },
                    child: const Text('Delete',
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
