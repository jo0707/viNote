import 'package:flutter/material.dart';
import 'package:vinote/main.dart';
import 'package:vinote/ui/values/texts.dart';
import 'package:vinote/utils.dart';

import '../../db/model/note.dart';
import '../values/colors.dart';
import '../values/widget.dart';

class EditScreen extends StatefulWidget {
  final Note? note;

  const EditScreen({this.note, Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState(note);
}

class _EditScreenState extends State<EditScreen> {
  Note? note;
  var titleController = TextEditingController(text: "My Title");
  var contentController = TextEditingController();

  _EditScreenState(this.note) {
    titleController.text = note != null ? note!.title : "Title";
    contentController.text = note != null ? note!.content : "";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Background(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 700) {
              return MobileEditingLayout(
                  widget.note, titleController, contentController);
            } else {
              return WebEditingLayout(
                  widget.note, titleController, contentController);
            }
          }),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}

class MobileEditingLayout extends StatelessWidget {
  final Note? note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  const MobileEditingLayout(
      this.note,
      this.titleController,
      this.contentController,
      {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                        primary: purple),
                    child: const Icon(Icons.arrow_back),
                    onPressed: () => ConfirmDialog(
                        context,
                        "Cancel",
                        "Do you want to cancel this note?",
                            () => Navigator.pop(context)
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                        primary: green),
                    child: const Icon(Icons.check),
                    onPressed: () =>
                        saveNote(
                            context,
                            Note(
                                titleController.text,
                                contentController.text,
                                note?.timestamp ?? DateTime.now().millisecondsSinceEpoch),
                            note?.key
                        )
                  )
                ]
            )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: titleController,
            maxLines: 1,
            maxLength: 32,
            style: const TextStyle(color: Colors.white, fontSize: 24),
            decoration: const InputDecoration(counter: SizedBox.shrink()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: h6(getTime(note?.timestamp),
              color: Colors.white.withOpacity(0.9)),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 24),
            child: MyCard(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Start writing...",
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WebEditingLayout extends StatelessWidget {
  final Note? note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  const WebEditingLayout(
      this.note,
      this.titleController,
      this.contentController,
      {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: TextField(
                    controller: titleController,
                    maxLength: 32,
                    minLines: 1,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    decoration: const InputDecoration(counter: SizedBox.shrink())
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  child: h6(getTime(note?.timestamp), color: Colors.white.withOpacity(0.9)),
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(32),
                                primary: purple),
                            child: const Icon(Icons.arrow_back),
                            onPressed: () {
                              ConfirmDialog(
                                  context,
                                  "Cancel",
                                  "Do you want to cancel this note?",
                                      () => Navigator.pop(context)
                              );
                              },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(32),
                                primary: green),
                            child: const Icon(Icons.check),
                            onPressed: () => saveNote(
                                context,
                                Note(
                                    titleController.text,
                                    contentController.text,
                                    note?.timestamp ??
                                        DateTime.now().millisecondsSinceEpoch),
                                note?.key)
                          )
                        ]
                    )
                ),
              ],
            )
        ),
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Start writing...",
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

saveNote(BuildContext context, Note note, int? id) {
  if (note.title.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text("Title cannot be empty"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: (){},
        ),
      )
    );

    return;
  }

  if (id == null) {
    db.insertNote(note).then((_) => Navigator.pop(context));
  } else {
    db.updateNote(note, key: id).then((_) => Navigator.pop(context));
  }
}

getTime(int? millis) => millis != null ? formatDate(millis: millis) : "Now";
