import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kokotoa Zaka',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display1: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),

      home: MyHomePage(title: 'Kokotoa Mgawanyo wa Sadaka'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    // This should be called after the calculate button is pressed
    setState(() {
      _userSadaka = double.parse(inputController.text);
      // what if _userSadaka is 0? Pop up alert dialog
      _sadakaECT = _userSadaka * 0.58;
      _sadakaKanisani = _userSadaka * 0.43;
    });
  }

  void _clearSadakaPercentage() {
    // When we clear the input field this be called
    setState(() {
          _sadakaECT = 0;
          _sadakaKanisani = 0;
    });
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.all(40.0),
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kiasi cha sadaka:',
              style: Theme.of(context).textTheme.display1,
            ),

            TextField(
              style: Theme.of(context).textTheme.display1,
              decoration: InputDecoration(
                //labelText: 'Kiasi cha sadaka:',
                prefixText: 'Tsh. ',

                // For clearing input field
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
      
                  onPressed: () {
                    inputController.clear();
                    _clearSadakaPercentage();
                  },
                )
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: inputController,
            ),

            // Spacer(flex: 1),

            Text(
              'Sadaka ya Pomoja ECT (58%):',
              style: Theme.of(context).textTheme.display1,
            ),

            Text(
              '$_sadakaECT',
              style: Theme.of(context).textTheme.display1,
            ),

            // Spacer(flex: 1),
            Text(
              'Sadaka ya Pomoja Kanisani (58%):',
              style: Theme.of(context).textTheme.display1,
            ),

            Text(
              '$_sadakaKanisani',
              style: Theme.of(context).textTheme.display1,
            ),

            // With instant value changes this button is redundant.
            // RaisedButton(
            //   child: Text('Kokotoa'),
            //   onPressed: _calculateSadakaPercentage,
            // ),
          ],
        ),
      ),
      ),
    );
  }
}
