import 'package:flutter/material.dart';

void main() => runApp(SadakaCalc());

class SadakaCalc extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kokotoa Mgawanyo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
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
  double _fontsize = 20;
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
      _userSadaka = double.parse(inputController.text);
      _sadakaECT = _userSadaka * 0.58;
      _sadakaKanisani = _userSadaka * 0.42;
    });
  }

  void _clearSadakaPercentage() {
    // When we clear the input field this be called
    setState(() {
          _sadakaECT = 0;
          _sadakaKanisani = 0;
    });
  }

  // Card decorations
  BoxDecoration _decorateCard() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(10.0),

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // To avoid 'Bottom overflowed by xyz pixels' error message
      // Consider using one of scrolling widgets, e.g. ListView,
      // NestedScrollView, GridView, SingleChildScrollView, Scrollable.
      resizeToAvoidBottomPadding: false,

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
                                _clearSadakaPercentage();
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
                            "Kanisani (42)",
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
