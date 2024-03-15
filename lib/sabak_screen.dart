import 'dart:developer';

import 'package:flutter/material.dart';

class SabakScreen extends StatefulWidget {
  const SabakScreen({Key? key}) : super(key: key);

  @override
  _SabakScreenState createState() => _SabakScreenState();
}

class _SabakScreenState extends State<SabakScreen> {
  /// List
  /// Map<Key, Value> => key = klyuch, value = maalimat

  List baalarList = [4, 5, 2];

  /// synchronuous programming
  Map<String, dynamic> baalar = {
    "azamat": 4,
    "aibek": 'kelbedi',
    "aigul": 2,
  };

  /// Future (Promise), asynchronous programming,
  /// asinhronnoe programmirovanie

  @override
  void initState() {
    for (var value in baalar.entries) {
      print('value.key: ${value.key} ');
      print('value.value: ${value.value} ');
    }

    for (var key in baalar.keys) {
      log('key: $key');
    }

    for (var value in baalar.values) {
      log('value: $value');
    }

    log('aigul: ${baalar['aigul']}');
    log('baalar.keys: ${baalar.keys}');
    log('baalar.values: ${baalar.values}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
