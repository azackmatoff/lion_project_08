import 'package:lion_project_08/domain/models/client_currency.dart';

sealed class HomeScreenBlocState {}

final class Initial extends HomeScreenBlocState {}

final class Success extends HomeScreenBlocState {
  final ClientCurrency clientCurrency;

  Success({
    required this.clientCurrency,
  });
}
