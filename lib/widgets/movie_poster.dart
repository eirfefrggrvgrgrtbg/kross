import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const MoviePoster({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  String? get _imageUrl {
    // Проверяем все возможные источники URL
    if (movie.posterUrl != null && movie.posterUrl!.startsWith('http')) {
      return movie.posterUrl;
    }
    if (movie.posterAssetPath != null && movie.posterAssetPath!.startsWith('http')) {
      return movie.posterAssetPath;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    final url = _imageUrl;

    // Загружаем из сети если есть URL
    if (url != null) {
      image = CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => Container(
          color: Colors.grey[800],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
          ),
        ),
        errorWidget: (context, url, error) {
          debugPrint('Image load error: $error for $url');
          return _buildPlaceholder();
        },
      );
    }
    // Локальный asset
    else if (movie.posterAssetPath != null && movie.posterAssetPath!.isNotEmpty) {
      image = Image.asset(
        movie.posterAssetPath!,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } 
    // Бинарные данные
    else if (movie.poster != null) {
      image = Image.memory(
        movie.poster!,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      image = _buildPlaceholder();
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.movie, size: 48, color: Colors.grey),
      ),
    );
  }
}
