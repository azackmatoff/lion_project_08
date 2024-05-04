part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenCubitState {}

final class HomeScreenInitial extends HomeScreenCubitState {}

final class HomeScreenSucces extends HomeScreenCubitState {
  final ClientCurrency clientCurrency;

  HomeScreenSucces({
    required this.clientCurrency,
  });
}
