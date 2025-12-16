import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final int year;
  final String genre;
  final int durationMinutes;
  final double rating;
  final String description;
  final Uint8List? poster;
  final String? posterAssetPath;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.durationMinutes,
    required this.rating,
    required this.description,
    this.poster,
    this.posterAssetPath,
  });

  Movie copyWith({
    int? id,
    String? title,
    int? year,
    String? genre,
    int? durationMinutes,
    double? rating,
    String? description,
    Uint8List? poster,
    String? posterAssetPath,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      poster: poster ?? this.poster,
      posterAssetPath: posterAssetPath ?? this.posterAssetPath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        year,
        genre,
        durationMinutes,
        rating,
        description,
        poster,
        posterAssetPath,
      ];
}

