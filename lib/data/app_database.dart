import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
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
    final count = await (select(movies)..limit(1)).get();
    if (count.isEmpty) {
      for (final movie in mockMovies) {
        Uint8List? posterBytes;
        if (movie.posterAssetPath != null) {
          try {
            final byteData = await rootBundle.load(movie.posterAssetPath!);
            posterBytes = byteData.buffer.asUint8List();
          } catch (e) {
            posterBytes = null;
          }
        }

        await into(movies).insert(
          MoviesCompanion.insert(
            title: movie.title,
            year: movie.year,
            genre: movie.genre,
            durationMinutes: movie.durationMinutes,
            rating: movie.rating,
            description: movie.description,
            poster: Value(posterBytes),
            posterAssetPath: Value(movie.posterAssetPath),
          ),
        );
      }
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cineonline.sqlite'));
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
      posterAssetPath: posterAssetPath,
    );
  }
}

