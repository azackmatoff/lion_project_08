import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lion_project_08/data/sources/api_source/api_sources.dart';
import 'package:lion_project_08/domain/models/client_currency.dart';
import 'package:lion_project_08/domain/repositories/sources_repositories.dart';

part 'home_screen_cubit_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenCubitState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  final SourcesRepositories _sourceRepo = SourcesRepositories(
    apiSources: ApiSources(),
  );

  Future<void> getCryptoRate(String currency) async {
    final result = await _sourceRepo.getBtcToCurrencyPrice(currency);

    emit(HomeScreenSucces(clientCurrency: result));
  }
}
