import 'package:get_it/get_it.dart';
import 'package:givva_events/data/repositories/fundraiser_repository.dart';
import 'package:givva_events/logic/bloc/fundraiser_bloc.dart';

/// Global service locator
final GetIt locator = GetIt.instance;

/// Initializes the dependency injection container.
void setupLocator() {
  // Repositories
  locator
    ..registerLazySingleton<FundraiserRepository>(
      FundraiserRepository.new,
    )
    // Blocs
    // We register it as a factory because we usually want a fresh instance per screen,
    // but in this specific app, we might share it.
    ..registerFactory(
      () => FundraiserBloc(repository: locator<FundraiserRepository>()),
    );
}
