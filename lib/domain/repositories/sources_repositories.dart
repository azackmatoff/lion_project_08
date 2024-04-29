import 'package:lion_project_08/data/sources/api_source/api_sources.dart';
import 'package:lion_project_08/domain/models/client_currency.dart';

class SourcesRepositories {
  final ApiSources _apiSources;
  SourcesRepositories({
    required ApiSources apiSources,
  }) : _apiSources = apiSources;

  Future<ClientCurrency> getBtcToCurrencyPrice(String currency) async {
    final serverClient = await _apiSources.getBtcToCurrencyPrice(currency);

    return ClientCurrency(
      currentRate: serverClient.rate,
      selectedCurrency: currency,
    );
  }
}
