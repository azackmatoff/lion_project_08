import 'package:get/get.dart';
import 'package:lion_project_08/data/sources/api_source/api_sources.dart';
import 'package:lion_project_08/domain/models/client_currency.dart';
import 'package:lion_project_08/domain/repositories/sources_repositories.dart';

class HomeScreenController extends GetxController {
  final SourcesRepositories _sourceRepo = SourcesRepositories(
    apiSources: ApiSources(),
  );

  Rx<ClientCurrency?> clientCurrency = ClientCurrency.empty().obs;

  RxBool loading = true.obs;

  @override
  void onInit() {
    getCryptoRate('USD');
    super.onInit();
  }

  Future<void> getCryptoRate(String currency) async {
    final result = await _sourceRepo.getBtcToCurrencyPrice(currency);

    clientCurrency.value = result;

    loading.value = false;
  }
}
