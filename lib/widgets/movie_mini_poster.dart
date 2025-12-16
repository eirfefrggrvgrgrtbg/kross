import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_poster.dart';

class MovieMiniPoster extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieMiniPoster({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: MoviePoster(
                movie: movie,
                width: 100,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
