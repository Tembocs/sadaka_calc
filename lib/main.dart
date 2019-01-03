import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() => runApp(SadakaCalc());

class SadakaCalc extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kokotoa Mgawanyo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
//        textTheme: TextTheme(
//          display1: TextStyle(
//            color: Colors.black,
//            fontSize: 20,
//          ),
//        ),
      ),

      home: MainHomePage(title: 'Kokotoa Mgawanyo'),
    );
  }
}

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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputController.dispose();
    super.dispose();
  }

  void _calculateSadakaPercentage() {
    setState(() {
      // So that when there is nothing we have 0 as a value internally
      if (inputController.text == '') {
        _userSadaka = 0;
      } else {
        _userSadaka = double.parse(inputController.text);
      }

      _sadakaECT = _userSadaka * 0.58;
      _sadakaKanisani = _userSadaka * 0.42;
    });
  }

  // Card decorations
  BoxDecoration _decorateCard() {
    return BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(20.0),

      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 3
        )
      ]
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
      // To avoid 'Bottom overflowed by xyz pixels' error message
      // Consider using one of scrolling widgets, e.g. ListView,
      // NestedScrollView, GridView, SingleChildScrollView, Scrollable.
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: Icon(
          Icons.equalizer,
        ),
      ),

      body: Center(
        child: Container(
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
                          "Sadaka",
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

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: _fontsize,
                          ),
                          
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),

                              onPressed: () {
                                inputController.clear();
                              }
                            )
                          )
                        )
                      )
                    ],
                  )
                  //child: Text("First item, Expanded"),
                ),

              ),

              Expanded(
                // Second card with TextFormField
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
                            style: TextStyle(
                              fontSize: _fontsize
                            ),
                          ),
                        ),

                        Container(
                          child: Text(
                            '${_sadakaECT.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: _fontsize
                            ),
                          )
                        )
                      ],
                    )
                  //child: Text("First item, Expanded"),
                ),
              ),

              Expanded(
                // Third card with TextFormField
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
                            style: TextStyle(
                              fontSize: _fontsize
                            ),
                          ),
                        ),

                        Container(
                            child: Text(
                              '${_sadakaKanisani.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: _fontsize
                              ),
                            )
                        )
                      ],
                    )
                  //child: Text("First item, Expanded"),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
