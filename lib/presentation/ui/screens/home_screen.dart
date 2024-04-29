import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lion_project_08/commons/constants/app_constants.dart';
import 'package:lion_project_08/data/sources/api_source/api_sources.dart';
import 'package:lion_project_08/domain/models/client_currency.dart';
import 'package:lion_project_08/domain/repositories/sources_repositories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SourcesRepositories _sourceRepo = SourcesRepositories(apiSources: ApiSources());

  ClientCurrency? clientCurrency;

  @override
  void initState() {
    getCryptoRate('USD');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\u{1F602} Coin Ticker'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: clientCurrency == null ? const CircularProgressIndicator() : _contentWithData(),
      ),
    );
  }

  Widget _contentWithData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '1 BTC = ${clientCurrency!.currentRate.toStringAsFixed(2)} ${clientCurrency!.selectedCurrency}',
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 32),
        buildForAndroid(),
      ],
    );
  }

  Widget buildForIos(BuildContext context) {
    return CupertinoButton(
      child: Text('Select Currency: ${clientCurrency!.selectedCurrency}'),
      onPressed: () => _showPicker(context),
    );
  }

  Widget buildForAndroid() {
    List<DropdownMenuItem<String>> items = [];

    for (var currency in AppConstants.currencies) {
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );

      items.add(item);
    }

    return DropdownButton(
      value: clientCurrency!.selectedCurrency,
      items: items,
      onChanged: (newCurrency) {
        getCryptoRate(clientCurrency!.selectedCurrency);
      },
    );
  }

  void _showPicker(BuildContext context) {
    List<Widget> children = [];

    for (final currency in AppConstants.currencies) {
      Widget child = Text(currency);

      children.add(child);
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CupertinoPicker(
          itemExtent: 42.0,
          onSelectedItemChanged: (selectedIndex) {
            getCryptoRate(AppConstants.currencies[selectedIndex]);
          },
          children: children,
        );
      },
    );
  }

  Future<void> getCryptoRate(String currency) async {
    final result = await _sourceRepo.getBtcToCurrencyPrice(currency);

    setState(() {
      clientCurrency = result;
    });
  }
}
