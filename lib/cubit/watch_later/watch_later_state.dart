part of 'watch_later_cubit.dart';

class WatchLaterState extends Equatable {
  final Set<int> watchLaterIds;

  const WatchLaterState({this.watchLaterIds = const {}});

  WatchLaterState copyWith({Set<int>? watchLaterIds}) {
    return WatchLaterState(
      watchLaterIds: watchLaterIds ?? this.watchLaterIds,
    );
  }

  @override
  List<Object> get props => [watchLaterIds];
}
