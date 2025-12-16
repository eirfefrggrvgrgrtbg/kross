import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../models/movie.dart';
import 'mock_movies.dart';

part 'app_database.g.dart';

class Movies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get year => integer()();
  TextColumn get genre => text()();
  IntColumn get durationMinutes => integer()();
  RealColumn get rating => real()();
  TextColumn get description => text()();
  BlobColumn get poster => blob().nullable()();
  TextColumn get posterAssetPath => text().nullable()();
}

@DriftDatabase(tables: [Movies])
@singleton
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
    );
  }

  Future<void> seedInitialData() async {
    // Проверяем количество фильмов - если меньше 30, пересоздаём
    final count = await select(movies).get();
    if (count.length < 30) {
      await delete(movies).go();
      for (final movie in mockMovies) {
        await into(movies).insert(
          MoviesCompanion.insert(
            title: movie.title,
            year: movie.year,
            genre: movie.genre,
            durationMinutes: movie.durationMinutes,
            rating: movie.rating,
            description: movie.description,
            poster: const Value(null),
            posterAssetPath: Value(movie.posterUrl), // Храним URL в posterAssetPath
          ),
        );
      }
    }
  }
  
  Future<void> resetAndSeed() async {
    await delete(movies).go();
    for (final movie in mockMovies) {
      await into(movies).insert(
        MoviesCompanion.insert(
          title: movie.title,
          year: movie.year,
          genre: movie.genre,
          durationMinutes: movie.durationMinutes,
          rating: movie.rating,
          description: movie.description,
          poster: const Value(null),
          posterAssetPath: Value(movie.posterUrl),
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cineonline_v2.sqlite')); // Новое имя файла БД
    return NativeDatabase.createInBackground(file);
  });
}

extension MovieEntryExtension on Movy {
  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      year: year,
      genre: genre,
      durationMinutes: durationMinutes,
      rating: rating,
      description: description,
      poster: poster,
      posterUrl: posterAssetPath, // URL хранится в posterAssetPath
    );
  }
}

