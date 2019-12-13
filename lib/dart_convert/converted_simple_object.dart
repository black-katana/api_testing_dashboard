// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class ConvertedSimpleObject {
  const ConvertedSimpleObject(
      {this.name, this.totalTests, this.totalErrors, this.totalFailures});

  final String name;
  final int totalTests;
  final int totalErrors;
  final int totalFailures;

  factory ConvertedSimpleObject.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ConvertedSimpleObject(
      name: json['name'] as String,
      totalTests: json['totalTests'] as int,
      totalErrors: json['totalErrors'] as int,
      totalFailures: json['totalFailures'] as int,
    );
  }
}
