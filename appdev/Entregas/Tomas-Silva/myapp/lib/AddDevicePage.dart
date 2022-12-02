import 'package:flutter/material.dart';

class DataList {
  DataList(this.title, [this.children = const <DataList>[]]);

  final String title;
  final List<DataList> children;
}

// Define a custom Form widget.
class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => AddDevicePageState();
}


class AddDevicePageState extends State<AddDevicePage> {
  final division = TextEditingController();
  final name = TextEditingController();
  final power = TextEditingController();
  final time = TextEditingController();

  static var division_NamePowerPrice = new Map();

  static List<DataList> dataList = <DataList>[];


  var price_by_div = {};
  static double price_total = 0.0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    division.dispose();
    name.dispose();
    power.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Device...'),
        backgroundColor: Color.fromARGB(255, 3, 58, 75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Division of the house:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: division,
            ),
            Text(
              'Name of the device:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: name,
            ),
            Text(
              'Power of the device (W):',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: power,
            ),
            Text(
              'Average time of working (Format: xh ym zs): ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: time,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //boring code :(

          //checking if every info is valid and make it valid if possible

          //division of the house
          division.text =
              division.text.toUpperCase(); //make always everything in uppercase

          //name of the device
          name.text =
              name.text.toUpperCase(); //make always everything in uppercase

          //check if power are numbers

          bool isNumeric(String s) {
            if (s == null) {
              return false;
            }
            return double.tryParse(s) != null;
          }

          //if power is a number we run the code
          if (isNumeric(power.text)) {
            double price_per_kwh = 0.15; //price for kwh in portugal

            double time_h = 0;

            int index = 0;
            for (int ii = 0; ii < time.text.length; ii++) {
              if (time.text[ii] == "h") {
                var value = double.parse(time.text.substring(index, ii));
                assert(value is double);
                time_h += value;
                index = ii + 1;
              }
              if (time.text[ii] == "m") {
                var value = double.parse(time.text.substring(index, ii));
                assert(value is double);
                time_h += value / 60;
                index = ii + 1;
              }
              if (time.text[ii] == "s") {
                var value = double.parse(time.text.substring(index, ii));
                assert(value is double);
                time_h += value / 3600;
                index = ii + 1;
              }
            }

            double power_num = double.parse(power.text);
            assert(power_num is double);
            double power_kwh = power_num / 1000;

            double price = power_kwh * price_per_kwh * time_h;
            price_total += price;
             //price by division of the house

            setState(() {});
            //if doesn't exists on map
            if (division_NamePowerPrice.containsKey(division.text) == false) {
              division_NamePowerPrice[division.text] = [
                [name.text, power_kwh, time_h, price.toStringAsFixed(2)]
              ];

            price_by_div[division.text] = price;
            
              
              dataList.add(
                DataList(
                  division.text +
                      ' : ' +
                      price_by_div[division.text].toStringAsFixed(2) +
                      '€',
                  <DataList>[
                    DataList(
                      name.text + " : " + price.toStringAsFixed(2) + "€",
                    ),
                  ],
                ),
              );
            } else {
              //if already exists on map
              division_NamePowerPrice[division.text].addAll([
                [name.text, power_kwh, time_h, price.toStringAsFixed(2)]
              ]);
              
              price_by_div[division.text] += price;

              //clean dataList
              dataList.clear();

              //add everything organized

              division_NamePowerPrice.forEach((key, value) {
                dataList.add(DataList(
                    key + ' : ' + price_by_div[key].toStringAsFixed(2) + '€',
                    <DataList>[
                      for (var ii = 0; ii < value.length; ii++)
                        DataList(
                          value[ii][0] +
                              " : " +
                              value[ii].last.toString() +
                              "€",
                        ),
                    ]));
              });
            }

            print(division_NamePowerPrice);

            //show what was added
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Added ' + division.text),
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('Please wright again correctly.'),
                );
              },
            );
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 3, 58, 75),
      ),
    );
  }
}
