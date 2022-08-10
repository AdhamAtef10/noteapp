import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_cubit.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/utlis/naviagtion.dart';
import 'package:noteapp/views/note_screen.dart';
import 'package:noteapp/views/update_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key,}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        return StreamBuilder(
          stream: cubit.noteRef.snapshots(),
          builder: (context,snapshot) {
            if(snapshot.hasData)
              {
                QuerySnapshot value=snapshot.data as QuerySnapshot;
                return Scaffold(
                  backgroundColor: Colors.grey[300],
                  appBar: AppBar(
                    backgroundColor: Colors.blueGrey,
                    centerTitle: true,
                    title: const Text('Note App'),
                  ),
                  body: ConditionalBuilder(
                    condition:value.docs.isNotEmpty ,
                    fallback: (context)=>Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const[
                          Icon(Icons.menu,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text('No Tasks Yet, Add Some Tasks !',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),)
                        ],
                      ),
                    ),
                    builder: (context)=>GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            crossAxisCount: 2),
                        itemCount: value.docs.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(value.docs[index].id),
                            onDismissed: (DismissDirection direction)
                            {
                              if(direction==DismissDirection.endToStart?
                              cubit.voidDelete(value.docs[index].id):
                              AppNavigator.customNavigator(
                                  context: context,
                                  screen: UpDateScreen(
                                    noteId: value.docs[index].id,
                                    noteObj: Note(
                                      noteText: value.docs[index]['text'],
                                      noteTitle: value.docs[index]['note_title'],
                                    ),
                                  ),
                                  finish:false
                              )
                              ) {}
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              if(direction==DismissDirection.endToStart?
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Confirmation"),
                                    content: const Text("Are you sure you want to delete this item?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed:()
                                        {
                                          cubit.voidDelete(value.docs[index].id);
                                          AppNavigator.customNavigator(
                                              context: context,
                                              screen: const HomeScreen(),
                                              finish: false
                                          );
                                        },
                                        child: const Text("Delete"),
                                      ),
                                      TextButton(
                                        onPressed: ()=>AppNavigator.customNavigator(
                                            context: context,
                                            screen: const HomeScreen(),
                                            finish: false
                                        ),
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              ) :AppNavigator.customNavigator(
                                  context: context,
                                  screen: UpDateScreen(
                                    noteId: value.docs[index].id,
                                    noteObj: Note(
                                      noteText: value.docs[index]['text'],
                                      noteTitle: value.docs[index]['note_title'],
                                    ),
                                  ),
                                  finish:false
                              )) {}
                              return null;
                            },
                            background: buildSwipeActionLeft(),
                            secondaryBackground: buildSwipeActionRight(),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Material(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      elevation: 20,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.blueGrey,
                                        ),
                                        width: 200,
                                        height: 150,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(value.docs[index]['note_title'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(value.docs[index]['text'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                  ),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      AppNavigator.customNavigator(
                        context: context,
                        screen: NoteScreen(),
                        finish: false,
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                );
              }
            else{
              return Container();
            }
          },
        );
      },
    );
  }
}


Widget buildSwipeActionLeft() => Container(
  alignment: Alignment.centerLeft,
  color: Colors.blue,
  child: const Icon(Icons.edit,
      color: Colors.white,
      size: 30),
);
Widget buildSwipeActionRight() => Container(
  alignment: Alignment.centerRight,
  padding: const EdgeInsets.symmetric(horizontal: 20),
  color: Colors.red,
  child: const Icon(Icons.delete_forever,
      color: Colors.white,
      size: 30),
);
