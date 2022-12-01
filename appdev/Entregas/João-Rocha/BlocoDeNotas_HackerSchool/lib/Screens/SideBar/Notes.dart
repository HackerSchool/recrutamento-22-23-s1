import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/Screens/Actions/EditNote.dart';
import 'package:notes/Screens/Actions/CreateNote.dart';
import 'package:notes/Screens/HomeScreen.dart';

bool noTitle = false;
bool noContent = false;

List<Map> searchedNotes = [];
final TextEditingController searchC = TextEditingController();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget leading() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (context) => createNote()),
                  )
                  .then((_) => setState(() {}));
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget nListView(
      List<Map> Notes, int reverseIndex, int dateValue, String date) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: showShadow ? 2 : 0),
        child: Stack(alignment: Alignment.topRight, children: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => EditNote(
                          Title: Notes[reverseIndex]["title"],
                          Content: Notes[reverseIndex]["content"],
                          index: Notes[reverseIndex]['cindex'],
                        )))
                .then((value) => setState(() {
                    })),
            child: Container(
              height: 300,
              width: 300,
              child: Card(
                color: colors[Notes[reverseIndex]['cindex']],
                elevation: showShadow ? 4 : 0,
                shadowColor: colors[Notes[reverseIndex]['cindex']],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 40,
                      bottom: showDate ? 15 : 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        noTitle
                            ? Container()
                            : Expanded(
                                flex: 2,
                                child: Text(Notes[reverseIndex]["title"],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24,
                                        color: Colors.white)),
                              ),
                        Expanded(
                          flex: 7,
                          child: Text(
                              noContent
                                  ? "Vazio"
                                  : Notes[reverseIndex]["content"],
                              maxLines: showDate ? 8 : 9,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      noContent ? Colors.white38 : Colors.white,
                                  fontSize: noTitle ? 21 : 16)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        showDate
                            ? Expanded(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Text(
                                      dateValue == 0
                                          ? "Hoje"
                                          : dateValue == -1
                                              ? "Ontem"
                                              : date,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          Notes[reverseIndex]["edited"] == "sim"
                                              ? "Editado"
                                              : "",
                                          style:
                                              TextStyle(color: Colors.white38),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: IconButton(
                focusColor: Colors.blue,
                onPressed: () async {
                  showDeleteDialog(index: reverseIndex, Notes: Notes);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 26,
                )),
          ),
        ]),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    List<Map> Notes = notesMap;
    return Scaffold(
      body: ListView(
        children: [
          customAppBar("Notas", 42, leading()),
          notesMap.length != 0
              ? viewIndex != 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Notes.length,
                          itemBuilder: (context, index) {
                            int reverseIndex = Notes.length - index - 1;
                            notesMap[reverseIndex]["title"] == ""
                                ? noTitle = true
                                : noTitle = false;
                            notesMap[reverseIndex]["content"] == ""
                                ? noContent = true
                                : noContent = false;
                            int dateValue = calculateDifference(
                                notesMap[reverseIndex]["time"]);
                            String date =
                                parseDate(notesMap[reverseIndex]["time"]);
                            Widget chosenView = viewIndex == 0
                                ? nListView(
                                    Notes, reverseIndex, dateValue, date)
                                : nListView(
                                    Notes, reverseIndex, dateValue, date);
                            return chosenView;
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Notes.length,
                          itemBuilder: (context, index) {
                            int reverseIndex = Notes.length - index - 1;
                            notesMap[reverseIndex]["title"] == ""
                                ? noTitle = true
                                : noTitle = false;
                            notesMap[reverseIndex]["content"] == ""
                                ? noContent = true
                                : noContent = false;
                            int dateValue = calculateDifference(
                                notesMap[reverseIndex]["time"]);
                            String date =
                                parseDate(notesMap[reverseIndex]["time"]);
                            return nListView(
                                Notes, reverseIndex, dateValue, date);
                          }),
                    )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: Center(
                      child: Text(
                    "Não tens nenhuma nota",
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.w400),
                  )),
                ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  int calculateDifference(String stringDate) {
    var date = DateTime.parse(stringDate);
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  String parseDate(String stringDate) {
    var date = DateTime.parse(stringDate);
    String parsedDate = DateFormat.MMMMd().format(date);
    return parsedDate;
  }

  Future<void> showDeleteDialog(
      {required List<Map> Notes, required int index}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Remover Nota",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text("Tens acerteza que queres apagar a nota?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancelar")),
            TextButton(
                onPressed: () async {
                  await deleteFromDatabase(id: Notes[index]["id"]);

                  Navigator.of(context).pop();
                },
                child: Text("Sim"))
          ],
        );
      },
    );
  }
}
