import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math' as math;
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// CRUD
/// C - Create
/// R - Read
/// U - Update
/// D - Delete
/// API
/// Scope, local scope, global scope

String apiKey = 'A15EF46F-E389-44DA-9118-2F4526A66C0D';
String apiUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentRate = 0;
  String selectedCurrency = 'USD';

  String? error;

  @override
  Widget build(BuildContext context) {
    // print('MediaQuery.of(context).size.height: ${MediaQuery.of(context).size.height}');
    // print('MediaQuery.of(context).size.width: ${MediaQuery.of(context).size.width}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('\u{1F602} Coin Ticker'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1 BTC = ${currentRate.toStringAsFixed(2)} $selectedCurrency',
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 32),
            buildForAndroid(),
          ],
        ),
      ),
    );
  }

  Widget buildForIos(BuildContext context) {
    return CupertinoButton(
      child: Text('Select Currency: $selectedCurrency'),
      // onPressed: () {
      //   _showPicker(context);
      // },
      onPressed: () => _showPicker(context),
    );
  }

  Widget buildForAndroid() {
    List<DropdownMenuItem<String>> items = [];

    /// for loop
    for (int i = 0; i < currencies.length; i++) {
      String currency = currencies[i];

      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );

      items.add(item);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: items,
      onChanged: (newCurrency) {
        setState(() {
          selectedCurrency = newCurrency!;
        });

        getCryptoRate(selectedCurrency);
      },
    );
  }

  void _showPicker(BuildContext context) {
    List<Widget> children = [];

    for (final currency in currencies) {
      Widget child = Text(currency);

      children.add(child);
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CupertinoPicker(
          itemExtent: 42.0,
          onSelectedItemChanged: (selectedIndex) {
            setState(() {
              selectedCurrency = currencies[selectedIndex];
            });

            getCryptoRate(selectedCurrency);
          },
          children: children,
        );
      },
    );
  }

  Future<void> getCryptoRate(String currency) async {
    http.Client client = http.Client();

    String url = '${apiUrl}BTC/$currency?apiKey=$apiKey';
    Uri uri = Uri.parse(url);
    http.Response response = await client.get(uri);

    dev.log('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      /// iygiliktuu maalimat keldi

      /// from JSON to dart, to Map
      Map result = jsonDecode(response.body);

      dev.log('response: ${response.body}');
      currentRate = result['rate'];
      setState(() {});
    } else {
      /// kata keldi
      dev.log('response error: ${response.body}');
    }

    // Map resultat = {
    //   "time": "2024-03-15T16:21:02.0000000Z",
    //   "asset_id_base": "BTC",
    //   "asset_id_quote": "CAD",
    //   "rate": 91405.34243313075904701829142
    // };
  }
}

List<String> currencies = [
  'USD', //0
  'CAD', //1
  'EUR',
  'KGS',
  'GBP',
  'JPY',
  'AUD',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
];
