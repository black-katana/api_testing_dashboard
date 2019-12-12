import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'API Status',
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
        ),
        home: LandingPage(title: 'API Testing Dashboard'));
    // home: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Athena'),
    //     ),
    //     body: Center(
    //       child: Text(uriResponse),
    //     )));
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // var _result = "Init";

  var _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // void _fetchData() async {
  //   var url = "https://www.googleapis.com/books/v1/volumes?q={http}";

  //   // Await the http get response, then decode the json-formatted responce.
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     var itemCount = jsonResponse['totalItems'];
  //     // print("Number of books about http: $itemCount.");
  //     setState(() {
  //       _result = jsonResponse;
  //     });
  //   } else {
  //     // print("Request failed with status: ${response.statusCode}.");
  //     setState(() {
  //       _result = "Request failed with status: ${response.statusCode}.";
  //     });
  //   }
  // }

  // #docregion _buildSuggestions
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
  // #enddocregion _buildRow

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
        // Here we take the value from the LandingPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        tooltip: 'Fetch',
        child: Icon(Icons.new_releases),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
