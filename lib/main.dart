import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_testing_dashboard/json_strings.dart';
import 'package:api_testing_dashboard/dart_convert/converted_complex_object.dart';
// import 'package:api_testing_dashboard/dart_convert/converted_simple_object.dart';
// import 'package:api_testing_dashboard/utils.dart';
import 'package:api_testing_dashboard/widgets.dart';

Future<List<Status>> fetchData(http.Client client) async {
  final response = await client.get('http://localhost:4567/statuses/proteus');
  return compute(parseStatus, response.body);
}

List<Status> parseStatus(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Status>((json) => Status.fromJson(json)).toList();
}

class Status {
  final String name;
  final int totalTests;
  final int totalErrors;
  final int totalFailures;
  final int totalSkips;
  final String rawData;

  Status(
      {this.name,
      this.totalTests,
      this.totalErrors,
      this.totalFailures,
      this.totalSkips,
      this.rawData});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        name: json['name'] as String,
        totalTests: json['totalTests'] as int,
        totalErrors: json['totalErrors'] as int,
        totalFailures: json['totalFailures'] as int,
        totalSkips: json['totalSkips'] as int,
        rawData: json['rawData'] as String);
  }
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Proteus API Status'),
        ),
        body: ConvertedListPage());
  }
}

// class LandingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Proteus API Status'),
//       ),
//       body: FutureBuilder<List<Status>>(
//         future: fetchData(http.Client()),
//         builder: (context, snapshot) {
//           print(snapshot);
//           if (snapshot.hasError) print(snapshot.error);

//           return snapshot.hasData
//               ? StatusList(statuses: snapshot.data)
//               : Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

// class StatusList extends StatelessWidget {
//   final List<Status> statuses;
//   StatusList({Key key, this.statuses}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // return ListView.builder(
//     //   itemCount: statuses.length,
//     //   itemBuilder: (context, index) {
//     //     return ListTile(title: Text('${statuses[index].name}'));
//     //   },
//     // );

//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//       ),
//       itemCount: statuses.length,
//       itemBuilder: (context, index) {
//         return Text(statuses[index].name);
//       },
//     );
//   }
// }

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
