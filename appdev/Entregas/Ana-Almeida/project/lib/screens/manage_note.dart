import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/home.dart';
import 'package:project/utils/color.dart';
import 'package:project/utils/note_service.dart';

class ManageNote extends StatefulWidget {
  const ManageNote({
    Key? key,
    required this.title,
    required this.isEdit,
    this.isView = false,
    this.id,
  }) : super(key: key);
  final String title;
  final bool isEdit;
  final bool isView;
  final String? id;

  @override
  State<ManageNote> createState() => _ManageNoteState();
}

class _ManageNoteState extends State<ManageNote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _note = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    if (widget.isEdit || widget.isView) {
      _getANote();
    }
    super.initState();
  }

  _createNote() {
    _isLoading = true;
    NoteService().createNote(_title.text, _note.text).then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note Created successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating Note!')),
      );
    });
  }

  _getANote() {
    _isLoading = true;
    NoteService().getANote(widget.id!).then((value) {
      setState(() {
        _isLoading = false;
      });
      _title.text = value.title;
      _note.text = value.note;
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  _updateNote() {
    _isLoading = true;
    NoteService().updateNote(_title.text, _note.text, widget.id!).then((value) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note Updated successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }).catchError((_) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating Note!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.primary,
              ))
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
                : Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //title
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                    color: AppColor.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                TextFormField(
                                  controller: _title,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please input title';
                                    }
                                    return null;
                                  },
                                  readOnly: widget.isView,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25)
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintText: "Enter title",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30.0),

                            //Note
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Note',
                                  style: TextStyle(
                                    color: AppColor.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                TextFormField(
                                  controller: _note,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please input note';
                                    }
                                    return null;
                                  },
                                  readOnly: widget.isView,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(70)
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    hintText: "Enter note",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColor.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  minLines: 6,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: widget.isView
                              ? const SizedBox()
                              : TextButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (widget.isEdit) {
                                              _updateNote();
                                            } else {
                                              _createNote();
                                            }
                                          }
                                        },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.primary),
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
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
}
