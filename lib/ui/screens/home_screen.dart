import 'package:flutter/material.dart';
import 'package:vinote/main.dart';
import 'package:vinote/ui/screens/edit_screen.dart';
import 'package:vinote/ui/values/texts.dart';

import '../../db/model/note.dart';
import '../../utils.dart';
import '../values/colors.dart';
import '../values/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteListWidget noteListWidget;

  @override
  Widget build(BuildContext context) {
    noteListWidget = NoteListWidget();

    return Stack(
        children: [
          const Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 8),
                    child: h2("Hello, $nickname", color: Colors.white, align: TextAlign.center)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: h4(getGreetings(), color: Colors.white, align: TextAlign.center)),
                  Expanded(
                    child: MyCard(child: noteListWidget))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: green,
              onPressed: () => addNote(context),
              child: const Icon(Icons.add)
            )
          )
        ]
    );
  }

  String getGreetings() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 17) {
      return "Good Afternoon!";
    } else if (hour < 22) {
      return "Good Evening!";
    } else {
      return "Good Night!";
    }
  }

  addNote(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EditScreen())
    ).then((_) => setState(() => noteListWidget = NoteListWidget()));
  }
}

class NoteListWidget extends StatefulWidget {
  const NoteListWidget({Key? key}) : super(key: key);

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  late List<Note> listNotes;

  @override
  Widget build(BuildContext context) {
    listNotes = db.getNotes();

    if (listNotes.isEmpty) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("no notes, create a new one", style: TextStyle(color: Colors.black.withOpacity(0.5))),
              const SizedBox(height: 16),
              Image.asset(
                "images/note.png",
                width: 100,
                color: Colors.black.withOpacity(0.1),
              )
            ]
          )
      );
    } else {
      var size = MediaQuery.of(context).size.width;

      if (size <= 600) {
        return ListView.builder(
            itemBuilder: (_, i) {
              var note = listNotes[i];
              return NoteListItem(note, refresh);
              },
            itemCount: listNotes.length);
      } else if (size <= 800) {
        return GridView.count(
          crossAxisCount: 3,
          children: listNotes.map((note) => NoteGridItem(note, refresh)).toList(),
        );
      } else if (size <= 1050) {
        return GridView.count(
          crossAxisCount: 4,
          children: listNotes.map((note) => NoteGridItem(note, refresh)).toList(),
        );
      } else if (size <= 1400) {
        return GridView.count(
          crossAxisCount: 5,
          children: listNotes.map((note) => NoteGridItem(note, refresh)).toList(),
        );
      } else {
        return GridView.count(
          crossAxisCount: 6,
          children: listNotes.map((note) => NoteGridItem(note, refresh)).toList(),
        );
      }
    }
  }

  refresh() => setState(() => listNotes = db.getNotes());
}

class NoteListItem extends StatelessWidget {
  final Note note;
  final Function refresh;

  const NoteListItem(this.note, this.refresh, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Card(
          elevation: 3,
          child: InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditScreen(note: note))
              ).then((_) => refresh.call());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
                        child: h5(note.title),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: Text(
                          formatDate(millis: note.timestamp),
                          style: TextStyle(color: textColor.withOpacity(0.7)),
                        )
                      )
                    ]
                  )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: red),
                    child: const Icon(Icons.delete),
                    onPressed: () => deleteNote(note.key),
                  )
                )
              ]
            )
          )
        )
    );
  }

  deleteNote(int key) => db.deleteNote(key).then((_) => refresh());
}

class NoteGridItem extends StatelessWidget {
  final Note note;
  final Function refresh;

  const NoteGridItem(this.note, this.refresh, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Card(
          elevation: 3,
          child: InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditScreen(note: note))
              ).then((_) => refresh.call());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
                      child: h5(note.title, align: TextAlign.center),
                    ),
                  ),
                  const Flexible(child: SizedBox.expand()),
                  Text(
                    formatDate(millis: note.timestamp),
                    style: TextStyle(color: textColor.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: red),
                        child: const Icon(Icons.delete),
                        onPressed: () => deleteNote(note.key),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  deleteNote(int key) {
    db.deleteNote(key).then((_) => refresh());
  }
}