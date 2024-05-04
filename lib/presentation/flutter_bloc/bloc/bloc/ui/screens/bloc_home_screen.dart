import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lion_project_08/commons/constants/app_constants.dart';

import 'package:lion_project_08/domain/models/client_currency.dart';

import 'package:lion_project_08/presentation/flutter_bloc/bloc/bloc/home_screen_bloc.dart';
import 'package:lion_project_08/presentation/flutter_bloc/bloc/bloc/home_screen_bloc_state.dart';

class BlocHomeScreen extends StatefulWidget {
  const BlocHomeScreen({Key? key}) : super(key: key);

  @override
  _BlocHomeScreenState createState() => _BlocHomeScreenState();
}

class _BlocHomeScreenState extends State<BlocHomeScreen> {
  @override
  void initState() {
    context.read<HomeScreenBloc>().add(GetCrypto(currency: 'USD'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\u{1F602} Coin Ticker'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(child: BlocBuilder<HomeScreenBloc, HomeScreenBlocState>(
        builder: (context, state) {
          if (state is Initial) {
            return const CircularProgressIndicator();
          }

          return _contentWithData((state as Success).clientCurrency);
        },
      )),
    );
  }

  Widget _contentWithData(ClientCurrency clientCurrency) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '1 BTC = ${clientCurrency.currentRate.toStringAsFixed(2)} ${clientCurrency.selectedCurrency}',
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 32),
        buildForAndroid(clientCurrency),
      ],
    );
  }

  Widget buildForIos(BuildContext context, ClientCurrency clientCurrency) {
    return CupertinoButton(
      child: Text('Select Currency: ${clientCurrency.selectedCurrency}'),
      onPressed: () => _showPicker(context),
    );
  }

  Widget buildForAndroid(ClientCurrency clientCurrency) {
    List<DropdownMenuItem<String>> items = [];

    for (var currency in AppConstants.currencies) {
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );

      items.add(item);
    }

    return DropdownButton(
      value: clientCurrency.selectedCurrency,
      items: items,
      onChanged: (newCurrency) {
        context.read<HomeScreenBloc>().add(GetCrypto(currency: newCurrency!));
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
            context.read<HomeScreenBloc>().add(GetCrypto(currency: AppConstants.currencies[selectedIndex]));
          },
          children: children,
        );
      },
    );
  }
}
