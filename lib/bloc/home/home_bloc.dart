import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/movies_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository _moviesRepository;

  HomeBloc(this._moviesRepository) : super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      await _moviesRepository.seedInitialData();
      final movies = await _moviesRepository.getAllMovies();
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshMovies(
      RefreshMovies event, Emitter<HomeState> emit) async {
    try {
      final movies = await _moviesRepository.getAllMovies();
      emit(HomeLoaded(movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

