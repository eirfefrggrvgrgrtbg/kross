// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../bloc/home/home_bloc.dart' as _i47;
import '../cubit/theme/theme_cubit.dart' as _i591;
import '../data/app_database.dart' as _i133;
import '../data/movies_repository.dart' as _i186;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i591.ThemeCubit>(() => _i591.ThemeCubit());
    gh.singleton<_i133.AppDatabase>(() => _i133.AppDatabase());
    gh.singleton<_i186.MoviesRepository>(
      () => _i186.MoviesRepository(gh<_i133.AppDatabase>()),
    );
    gh.factory<_i47.HomeBloc>(
      () => _i47.HomeBloc(gh<_i186.MoviesRepository>()),
    );
    return this;
  }
}
