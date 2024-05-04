import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lion_project_08/commons/constants/app_constants.dart';
import 'package:lion_project_08/presentation/getx/controllers/home_screen_controller.dart';

class GetxHomeScreen extends StatelessWidget {
  GetxHomeScreen({Key? key}) : super(key: key);

  final HomeScreenController _controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\u{1F602} Coin Ticker'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Obx(
        () => Center(
          child: _controller.loading.value ? const CircularProgressIndicator() : _contentWithData(),
        ),
      ),
    );
  }

  Widget _contentWithData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '1 BTC = ${_controller.clientCurrency.value!.currentRate.toStringAsFixed(2)} ${_controller.clientCurrency.value!.selectedCurrency}',
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
      child: Text('Select Currency: ${_controller.clientCurrency.value!.selectedCurrency}'),
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
      value: _controller.clientCurrency.value!.selectedCurrency,
      items: items,
      onChanged: (newCurrency) {
        _controller.getCryptoRate(newCurrency!);
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
            _controller.getCryptoRate(AppConstants.currencies[selectedIndex]);
          },
          children: children,
        );
      },
    );
  }
}
