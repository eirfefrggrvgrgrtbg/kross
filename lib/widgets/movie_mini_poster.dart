import 'package:flutter/material.dart';

import '../models/movie.dart';

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: movie.poster != null
                    ? Image.memory(
                        movie.poster!,
                        fit: BoxFit.cover,
                        width: 100,
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.movie, color: Colors.grey),
                        ),
                      ),
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

