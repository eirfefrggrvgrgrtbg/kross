part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final Set<int> favoriteIds;

  const FavoritesState({this.favoriteIds = const {}});

  FavoritesState copyWith({Set<int>? favoriteIds}) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object> get props => [favoriteIds];
}

