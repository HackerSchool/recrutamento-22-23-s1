import 'package:dart_example/dart_example.dart' as dart_example;

void main(List<String> arguments) {
  // your code here
  var a = 1;
  int b = 1;
  dynamic c = 1;

  List<String> listOfStrings = [];
  Map<int, bool> mapOfIntToBool = {};

  print(int2double(1));
  print(int2Double(1));

  // usual constructor
  Car teslaS = Car("Tesla", "S", 2012, true);
  // named constructor
  Car fiatBravo = Car.hasABS("Fiat", "Bravo", 1995);
  // named constructor with positional arguments
  Car ferrariStradale = Car.diy(
    yearMade: 2019,
    model: "Stradale",
    make: "Ferrari",
    hasABS: true,
  );
}

double int2double(int i) => i.toDouble();

double int2Double(int i) {
  return i.toDouble();
}

class Car {
  String make;
  String model;
  int yearMade;
  bool hasABS;

  Car(this.make, this.model, this.yearMade, this.hasABS);
  // named constructor
  Car.hasABS(this.make, this.model, this.yearMade) : this.hasABS = true;
  // optional-position arguments
  Car.diy({
    this.make = "Ford",
    this.model = "Fiesta",
    this.yearMade = 2019,
    required this.hasABS,
  });
}
