// import 'package:appwrite/appwrite.dart';
import 'package:project/models/note.dart';
// import 'package:note_app/utils/setup.dart';

class NoteService {
//   // Client client = Client();
//   // Database? db;

  static List<Note> noteList = List.empty(growable: true);
  static int uuid = 0;

  NoteService() {
    // _init();
    // noteList = List.empty();
  }

  //initialize the application
  // _init() async {
  // client
  //     .setEndpoint(AppConstant().endpoint)
  //     .setProject(AppConstant().projectId);

  // db = Database(client);
// }

  _getUUID() {
    return uuid++;
  }

  Future<List<Note>> getAllNotes() async {
    try {
      // noteList.forEach((element) => print(element.title));
      return noteList;
    } catch (e) {
      throw Exception('Error getting list notes');
    }
  }

  Future<Note> createNote(String title, String note) async {
    try {
      Note newNote = Note(id: _getUUID().toString(), note: note, title: title);

      noteList.add(newNote);
      // noteList.forEach((element) => print(element.title));
      return newNote;
    } catch (e) {
      throw Exception('Error creating note');
    }
  }

  Future<Note> getANote(String id) async {
    try {
      return noteList.firstWhere((element) => element.id == id);
    } catch (e) {
      throw Exception('Error getting note');
    }
  }

  Future updateNote(String title, String note, String id) async {
    try {
      Note updateNote = Note(id: id, note: note, title: title);
      return noteList[noteList.indexWhere((element) => element.id == id)] =
          updateNote;
    } catch (e) {
      throw Exception('Error creating note');
    }
  }

  Future deleteNote(String id) async {
    try {
      return noteList.removeWhere((element) => element.id == id);
    } catch (e) {
      throw Exception('Error getting note');
    }
  }
}
