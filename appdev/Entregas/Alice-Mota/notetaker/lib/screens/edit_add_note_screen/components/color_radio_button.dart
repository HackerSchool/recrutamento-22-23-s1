import 'package:flutter/material.dart';

class ColorRadioButton extends StatelessWidget {
  final List<Color> colorItems;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final double radioButtonSize;

  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final double padding;
  final Color alphaBlendColor;

  const ColorRadioButton({
    Key? key,
    required this.colorItems,
    required this.currentIndex,
    required this.onTap,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding = 8.0,
    this.radioButtonSize = 30.0,
    this.alphaBlendColor = const Color(0xBBFFFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (int _index = 0; _index < colorItems.length; _index++)
            Container(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onTap!(_index);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: radioButtonSize,
                    width: radioButtonSize,
                    color: currentIndex == _index
                        ? colorItems[_index]
                        : Color.alphaBlend(alphaBlendColor, colorItems[_index]),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
