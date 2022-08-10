// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_cubit.dart';
import 'package:noteapp/utlis/naviagtion.dart';
import 'package:noteapp/views/home_screen.dart';

class NoteScreen extends StatelessWidget {
   NoteScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();

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
            title: const Text('Add New Task'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.titleController,
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
                    controller: cubit.noteController,
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
                      if (formKey.currentState!.validate()) {
                        cubit.titleController.text;
                        cubit.noteController.text;
                        await cubit.voidSave(cubit.titleController.text, cubit.noteController.text);
                        AppNavigator.customNavigator(
                          context: context,
                          screen: const HomeScreen(),
                          finish: false,
                        );
                      }
                    },
                    child: const Text('Save',
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
