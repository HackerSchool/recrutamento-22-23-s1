class TheCards {
  var cardQnA = [
    {
      "key": 1,
      "question": "Data1",
      "answer": "Answer1",
      "favorite": false,
    },
    {
      "key": 2,
      "question": "Data2",
      "answer": "Answer2",
      "favorite": false,
    },
    {
      "key": 3,
      "question": "Data3",
      "answer": "Answer3",
      "favorite": false,
    },
  ];

  bool resetMap = false;

  TheCards({this.resetMap = false}) {
    //TheCards({this.question = "", this.answer = "", this.favorite = false, this.resetMap = false}) {
    if (resetMap) {
      cardQnA.clear();
    }
  }

  void add({required String question, String answer = ".t.", bool favorite = false}) {
    int maxn = -1;
    for (var i = 0; i < cardQnA.length; i++) {
      int n = cardQnA[i]["key"] as int;
      maxn = (maxn < n) ? n : maxn;
    }
    maxn++;
    cardQnA.add({
      "key": maxn,
      "question": question,
      "answer": answer,
      "favorite": favorite,
    });
  }

  void loadParsedJson(parsedCardsJSON) {
    cardQnA.clear();

    for (var i = 0; i < parsedCardsJSON.length; i++) {
      cardQnA.add({});
      cardQnA[i]["key"] = parsedCardsJSON[i]["key"];
      cardQnA[i]["question"] = parsedCardsJSON[i]["question"];
      cardQnA[i]["answer"] = parsedCardsJSON[i]["answer"];
      cardQnA[i]["favorite"] = parsedCardsJSON[i]["favorite"];
    }
  }
}
