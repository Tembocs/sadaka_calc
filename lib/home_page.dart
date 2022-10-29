import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zaka/input_formatter.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  double _fontsize = 28;
  double _userSadaka = 0;
  double _sadakaECT = 0;
  double _sadakaKanisani = 0;
  final inputController = TextEditingController();
  final _thousandSeparatorFormatter = NumericTextFormatter();
//  final _thousandSeparatorFormatter = ThousandSeparatorTextInputFormatter();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputController.dispose();
    super.dispose();
  }

  void _calculateSadakaPercentage() {
    setState(
      () {
        // To ensure valid calculation
        if (inputController.text == '') {
          _userSadaka = 0;
        } else {
          // To avoid 'invalid double' error
          var inputText = inputController.text.replaceAll(RegExp(r','), '');
          _userSadaka = double.parse(inputText);
        }

        _sadakaECT = _userSadaka * 0.58;
        _sadakaKanisani = _userSadaka * 0.42;
      },
    );
  }

  // Add thousands separator
  String _separateThousands(String value) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return value.replaceAllMapped(reg, mathFunc);
  }

  // Card decorations
  BoxDecoration _decorateCard() {
    return BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(3, 3), blurRadius: 3)
      ],
    );
  }

  // So that we have instant results as user types
  @override
  void initState() {
    super.initState();
    inputController.addListener(_calculateSadakaPercentage);
  }

  @override
  Widget build(BuildContext context) {
    // To prevention rotation of the app when user rotate the device.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(
          Icons.equalizer,
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                // First card with TextFormField
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  //color: Colors.lightBlueAccent,
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment(0, 0),
                  decoration: _decorateCard(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Toleo",
                          style: TextStyle(
                            fontSize: _fontsize,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: inputController,
                          inputFormatters: <TextInputFormatter>[
                            _thousandSeparatorFormatter,
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: _fontsize,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                inputController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //child: Text("First item, Expanded"),
                ),
              ),
              Expanded(
                // Second card with Text
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  //color: Colors.lightBlueAccent,
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment(0, 0),
                  decoration: _decorateCard(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "ECT (58%)",
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${_separateThousands(_sadakaECT.toStringAsFixed(1))}',
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      )
                    ],
                  ),
                  //child: Text("First item, Expanded"),
                ),
              ),
              Expanded(
                // Third card with Text
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  //color: Colors.lightBlueAccent,
                  constraints: BoxConstraints.expand(),
                  alignment: Alignment(0, 0),
                  decoration: _decorateCard(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Kanisani (42%)",
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${_separateThousands(_sadakaKanisani.toStringAsFixed(1))}',
                          style: TextStyle(fontSize: _fontsize),
                        ),
                      ),
                    ],
                  ),
                  //child: Text("First item, Expanded"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
