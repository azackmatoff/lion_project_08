import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentRate = 0;
  String selectedCurrency = 'USD';

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
              '1 BTC = $currentRate $selectedCurrency',
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 32),
            Platform.isIOS ? buildForIos(context) : buildForAndroid(),
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
          },
          children: children,
        );
      },
    );
  }
}

List<String> currencies = [
  'USD', //0
  'CAD', //1
  'KGS', //2
  'EUR',
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
