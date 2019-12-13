import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:api_testing_dashboard/json_strings.dart';
import 'package:api_testing_dashboard/dart_convert/converted_complex_object.dart';
// import 'package:api_testing_dashboard/dart_convert/converted_simple_object.dart';
import 'package:api_testing_dashboard/utils.dart';
import 'package:api_testing_dashboard/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'API Status',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage());
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LandingPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('API Testing Dashboard'),
      ),
      body: Center(
        child: ConvertedListPage(),
      ),
    );
  }
}

class ConvertedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dynamic parsedJson = json.decode(JsonStrings.listOfSimpleObjects);

    final dynamic deserializedObjects =
        parsedJson.map((dynamic o) => ConvertedComplexObject.fromJson(o));

    final dynamic listOfObjects = deserializedObjects.toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        SimpleObjectViewList(listOfObjects),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
