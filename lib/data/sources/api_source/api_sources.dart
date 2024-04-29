import 'package:lion_project_08/core/services/http_services/http_services.dart';
import 'package:lion_project_08/data/models/server_currency.dart';

class ApiSources {
  Future<ServerCurrency> getBtcToCurrencyPrice(String currency) async {
    final result = await HttpServices.get(currency);
    return ServerCurrency.fromMap(result);
  }
}
