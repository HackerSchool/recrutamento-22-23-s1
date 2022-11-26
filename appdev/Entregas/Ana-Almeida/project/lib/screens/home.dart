import 'package:flutter/material.dart';
import 'package:project/models/note.dart';
import 'package:project/utils/color.dart';
import 'package:project/utils/note_service.dart';
import 'package:project/widgets/card.dart';
import 'package:project/screens/manage_note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note>? notes;
  bool _isLoading = false;
  bool _isError = false;
  bool _isEmpty = false;

  @override
  void initState() {
    _getNoteList();
    super.initState();
  }

  _getNoteList() {
    setState(() {
      _isLoading = true;
    });
    NoteService().getAllNotes().then((value) {
      setState(() {
        notes = value;
        _isLoading = false;
        (notes == Null || notes?.length == 0)
            ? _isEmpty = true
            : _isEmpty = false;
      });
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  _deleteNote(String id) {
    NoteService().deleteNote(id).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note Deleted successfully!')),
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    }).catchError((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error deleting Note!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: AppColor.primary,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.primary,
              ))
            : _isEmpty
                ? const Center(
                    child: Text(
                      'Add your first note',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : _isError
                    ? const Center(
                        child: Text(
                          'Error loading notes',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notes?.length,
                        itemBuilder: (context, index) {
                          return NoteCard(
                              note: notes![index], onDelete: _deleteNote);
                        },
                      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ManageNote(
                  title: 'Create Note',
                  isEdit: false,
                ),
              ),
            );
          },
          backgroundColor: AppColor.primary,
          tooltip: 'Create Note',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
