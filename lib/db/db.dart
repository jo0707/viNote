import 'package:hive/hive.dart';

import 'model/note.dart';

class DB {
  late final Box box;

  DB(this.box);

  List<Note> getNotes() {
    return box.values.map((e) => e as Note).toList();
  }

  Future<Note?> getNote(int id) async {
    return box.getAt(id);
  }

  Future<int> insertNote(Note note) async {
    return box.add(note);
  }

  Future<void> updateNote(Note note, {dynamic key}) {
    return box.put(key ?? note.key, note);
  }

  Future<void> deleteNote(int id) {
    return box.delete(id);
  }
}