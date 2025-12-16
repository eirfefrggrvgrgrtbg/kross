import '../models/movie.dart';

final List<Movie> mockMovies = [
  const Movie(
    id: 1,
    title: 'Начало',
    year: 2010,
    genre: 'Фантастика',
    durationMinutes: 148,
    rating: 8.8,
    description:
        'Кобб — талантливый вор, лучший из лучших в опасном искусстве извлечения: он крадёт ценные секреты из глубин подсознания во время сна.',
    posterAssetPath: 'assets/images/1.jpg',
  ),
  const Movie(
    id: 2,
    title: 'Интерстеллар',
    year: 2014,
    genre: 'Фантастика',
    durationMinutes: 169,
    rating: 8.6,
    description:
        'Когда засуха, пыльные бури и вымирание растений приводят человечество к продовольственному кризису, группа исследователей отправляется в космос.',
    posterAssetPath: 'assets/images/2.jpg',
  ),
  const Movie(
    id: 3,
    title: 'Тёмный рыцарь',
    year: 2008,
    genre: 'Боевик',
    durationMinutes: 152,
    rating: 9.0,
    description:
        'Бэтмен поднимает ставки в войне с криминалом. С помощью лейтенанта Джима Гордона и прокурора Харви Дента он намеревается очистить Готэм.',
    posterAssetPath: 'assets/images/3.jpg',
  ),
  const Movie(
    id: 4,
    title: 'Матрица',
    year: 1999,
    genre: 'Фантастика',
    durationMinutes: 136,
    rating: 8.7,
    description:
        'Хакер Нео узнаёт, что мир, в котором он живёт, — это компьютерная симуляция, созданная машинами для контроля над людьми.',
    posterAssetPath: 'assets/images/4.jpg',
  ),
  const Movie(
    id: 5,
    title: 'Побег из Шоушенка',
    year: 1994,
    genre: 'Драма',
    durationMinutes: 142,
    rating: 9.3,
    description:
        'Бухгалтер Энди Дюфрейн обвинён в убийстве жены и её любовника. Несмотря на то, что он невиновен, его приговаривают к пожизненному заключению.',
    posterAssetPath: 'assets/images/5.jpg',
  ),
];

