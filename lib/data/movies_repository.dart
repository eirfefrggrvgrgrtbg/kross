import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../models/movie.dart';
import 'app_database.dart';

@singleton
class MoviesRepository {
  final AppDatabase _database;

  MoviesRepository(this._database);

  Future<List<Movie>> getAllMovies() async {
    final entries = await _database.select(_database.movies).get();
    return entries.map((e) => e.toMovie()).toList();
  }

  Future<Movie?> getMovieById(int id) async {
    final query = _database.select(_database.movies)
      ..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    return result?.toMovie();
  }

  Future<void> insertMovie(Movie movie) async {
    await _database.into(_database.movies).insert(
          MoviesCompanion.insert(
            title: movie.title,
            year: movie.year,
            genre: movie.genre,
            durationMinutes: movie.durationMinutes,
            rating: movie.rating,
            description: movie.description,
            poster: Value(movie.poster),
            posterAssetPath: Value(movie.posterAssetPath),
          ),
        );
  }

  Future<void> updateMovie(Movie movie) async {
    await (_database.update(_database.movies)
          ..where((tbl) => tbl.id.equals(movie.id)))
        .write(
      MoviesCompanion(
        title: Value(movie.title),
        year: Value(movie.year),
        genre: Value(movie.genre),
        durationMinutes: Value(movie.durationMinutes),
        rating: Value(movie.rating),
        description: Value(movie.description),
        poster: Value(movie.poster),
        posterAssetPath: Value(movie.posterAssetPath),
      ),
    );
  }

  Future<void> deleteMovie(int id) async {
    await (_database.delete(_database.movies)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<void> seedInitialData() async {
    await _database.seedInitialData();
  }
}

