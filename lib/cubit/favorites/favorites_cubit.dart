import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'favorites_state.dart';

@lazySingleton
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite(int movieId) {
    final updated = Set<int>.from(state.favoriteIds);
    if (updated.contains(movieId)) {
      updated.remove(movieId);
    } else {
      updated.add(movieId);
    }
    emit(state.copyWith(favoriteIds: updated));
  }

  bool isFavorite(int movieId) => state.favoriteIds.contains(movieId);

  void clearFavorites() => emit(const FavoritesState());
}
