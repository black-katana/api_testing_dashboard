abstract class JsonStrings {
  static final String listOfStrings = '["one", "two", "three"]';

  static final String listOfSimpleObjects = '''
  [
    {
      "name": "Athena",
      "totalTests": 12,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
    },
    {
      "name": "Proteus",
      "totalTests": 15,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
    },
    {
      "name": "Elli",
      "totalTests": 15,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
    },
    {
      "name": "Hermes",
      "totalTests": 15,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
    }
  ]
  ''';
  static final List<String> complexObjects = [
    '''
  {
      "name": "Blah, blah, blah.",
      "totalTests": 12,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
    },

    "aListOfObjects": [
      {
      "name": "Blah, blah, blah.",
      "totalTests": 12,
      "totalErrors": 1,
      "totalFailures":2,
      "totalSkips": 0
      },
    ]
  }''',
  ];
}
