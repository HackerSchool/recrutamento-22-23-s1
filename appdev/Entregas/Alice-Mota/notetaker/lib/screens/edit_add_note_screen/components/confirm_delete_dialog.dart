import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:notetaker/constants.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback? onPressedYes;
  const ConfirmDeleteDialog({Key? key, this.onPressedYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Column(
        children: [
          SvgPicture.asset(
            'assets/images/clean-document-delete.svg',
            height: size.height * 0.2,
          ),
          //const Text("Sei sicuro?"),
        ],
      ),
      /*
      actions: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlertDialogButton(
                  text: "Annulla",
                  onTap: () {
                    Navigator.pop(context);
                  }),
              AlertDialogButton(
                text: "Rimuovi",
                onTap: onPressedYes,
                backgroundcolor:
                    Color.alphaBlend(const Color(0xAAFFFFFF), kOrange),
              ),
            ])
      ],*/
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final Color backgroundcolor;
  const AlertDialogButton({
    Key? key,
    required this.text,
    this.onTap,
    this.backgroundcolor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            margin: EdgeInsets.zero,
            color: backgroundcolor,
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
