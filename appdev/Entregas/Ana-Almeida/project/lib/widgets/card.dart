import 'package:flutter/material.dart';
import 'package:project/models/note.dart';
import 'package:project/screens/manage_note.dart';
import 'package:project/utils/color.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note, required this.onDelete})
      : super(key: key);

  final Note note;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
      child: Container(
        height: 170.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [BoxShadow(color: AppColor.grey)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 9.0),
                  Text(
                    note.note,
                    style: const TextStyle(
                      color: AppColor.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColor.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CustomButton(
                  icon: Icons.remove_red_eye_outlined,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageNote(
                            title: 'View Note',
                            isEdit: true,
                            isView: true,
                            id: note.id),
                      ),
                    );
                  },
                ),
                _CustomButton(
                  icon: Icons.edit,
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageNote(
                            title: 'Edit Note', isEdit: true, id: note.id),
                      ),
                    );
                  },
                ),
                _CustomButton(
                  icon: Icons.delete,
                  ontap: () {
                    onDelete(note.id!);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.icon,
    required this.ontap,
  }) : super(key: key);

  final IconData icon;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 3.5,
        child: Icon(icon),
      ),
      onTap: ontap,
    );
  }
}
