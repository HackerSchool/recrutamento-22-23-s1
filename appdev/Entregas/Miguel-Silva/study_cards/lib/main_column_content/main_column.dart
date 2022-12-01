import 'package:flutter/material.dart';

import 'my_card.dart';
import '../the_cards.dart';

class MainColumn extends StatefulWidget {
  MainColumn({super.key, required this.theCards, required this.editOrOrderCard, required this.deleteCards, this.limitedVersion = false});
  TheCards theCards;
  final Future<void> Function({int? index, String? question, String? answer, bool? favorite}) editOrOrderCard;
  final Function(int index) deleteCards;
  bool limitedVersion;

  @override
  MainColumnState createState() => MainColumnState();
}

class MainColumnState extends State<MainColumn> {
  //widget.theCards
  double elevation = 3;
  int selectedCard = 1;

  double getElevation(int cardKey) => (cardKey == selectedCard) ? elevation : 3;

  void deleteCardsMid(int index) => setState(() {
        widget.deleteCards(index);
      });

  @override
  Widget build(BuildContext context) {
    Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Material(
            borderOnForeground: false,
            elevation: 0,
            color: const Color.fromARGB(0, 255, 255, 255), //draggableItemColor,
            shadowColor: const Color.fromARGB(0, 255, 255, 255), //draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return Scrollbar(
      interactive: true,
      thumbVisibility: true,
      child: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final Map<String, Object> item = widget.theCards.cardQnA.removeAt(oldIndex);
            widget.theCards.cardQnA.insert(newIndex, item);
            setState(() {
              widget.editOrOrderCard();
              //print(widget.theCards.cardQnA);
            });
          });
        },
        onReorderStart: (int i) {
          //print("START");
          elevation = 14;
          selectedCard = i;
        },
        onReorderEnd: (int i) {
          elevation = 3;
          selectedCard = i;
          //print("END");
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            key: ValueKey(widget.theCards.cardQnA[index]["key"]),
            color: const Color.fromARGB(0, 2, 2, 2), //Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: MyCard(
              card: widget.theCards.cardQnA[index],
              getElevation: getElevation,
              index: index,
              editOrOrderCard: widget.editOrOrderCard,
              deleteCards: deleteCardsMid,
              limitedVersion: widget.limitedVersion,
            ),
          );
        },
        itemCount: widget.theCards.cardQnA.length,
        proxyDecorator: proxyDecorator,
      ),
    );
  }
}
