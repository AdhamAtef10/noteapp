class Note
{
  late String noteTitle;
  late String noteText;

  Note({required this.noteTitle ,required this.noteText});

  Map<String,dynamic> toMap()
  {
    return
      {
        'text':noteText,
        'note_title':noteTitle,
      };
  }

}