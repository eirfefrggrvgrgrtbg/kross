import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'watch_later_state.dart';

@lazySingleton
class WatchLaterCubit extends Cubit<WatchLaterState> {
  WatchLaterCubit() : super(const WatchLaterState());

  void toggleWatchLater(int movieId) {
    final updated = Set<int>.from(state.watchLaterIds);
    if (updated.contains(movieId)) {
      updated.remove(movieId);
    } else {
      updated.add(movieId);
    }
    emit(state.copyWith(watchLaterIds: updated));
  }

  bool isInWatchLater(int movieId) => state.watchLaterIds.contains(movieId);

  void clearWatchLater() => emit(const WatchLaterState());
}
