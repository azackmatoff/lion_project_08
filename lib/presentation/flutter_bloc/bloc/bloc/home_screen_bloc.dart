import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lion_project_08/data/sources/api_source/api_sources.dart';
import 'package:lion_project_08/domain/repositories/sources_repositories.dart';
import 'package:lion_project_08/presentation/flutter_bloc/bloc/bloc/home_screen_bloc_state.dart';

part 'home_screen_event.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenBlocState> {
  final SourcesRepositories _sourceRepo = SourcesRepositories(
    apiSources: ApiSources(),
  );

  HomeScreenBloc() : super(Initial()) {
    on<HomeScreenEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCrypto>(_getCrypto);
  }

  Future<void> _getCrypto(GetCrypto event, Emitter<HomeScreenBlocState> emit) async {
    final result = await _sourceRepo.getBtcToCurrencyPrice(event.currency);

    emit(Success(clientCurrency: result));
  }
}
