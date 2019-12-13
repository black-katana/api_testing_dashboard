import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:api_testing_dashboard/json_strings.dart';
import 'package:api_testing_dashboard/dart_convert/converted_complex_object.dart';
// import 'package:api_testing_dashboard/dart_convert/converted_simple_object.dart';
import 'package:api_testing_dashboard/utils.dart';
import 'package:api_testing_dashboard/widgets.dart';

Future<Status> fetchData() async {
  final response = await http.get('http://localhost:4567/statuses/proteus');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Status.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Status {
  final String name;
  final int totalTests;
  final int totalErrors;
  final int totalFailures;
  final int totalSkips;
  final String rawData;

  Status(
      {
      this.name,
      this.totalTests,
      this.totalErrors,
      this.totalFailures,
      this.totalSkips,
      this.rawData});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        name: json['name']
        totalTests: json['totalTests'],
        totalErrors: json['totalErrors'],
        totalFailures: json['totalFailures'],
        totalSkips: json['totalSkips'],
        rawData: json['rawData']);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'API Status',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: LandingPage());
  // }
}

class _MyAppState extends State<MyApp> {
  Future<Status> apitStatus;

  @override
  void initState() {
    super.initState();
    apitStatus = fetchData();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
        // Here we take the value from the LandingPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('API Testing Dashboard'),
      ),
      body: Center(
        child: FutureBuilder<Status>(
          future: apitStatus,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }
        ),
      ),
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
