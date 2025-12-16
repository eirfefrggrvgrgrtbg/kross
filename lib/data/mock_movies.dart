import '../models/movie.dart';

final List<Movie> mockMovies = [
  // === ФАНТАСТИКА ===
  const Movie(
    id: 1,
    title: 'Начало',
    year: 2010,
    genre: 'Фантастика',
    durationMinutes: 148,
    rating: 8.8,
    description:
        'Кобб — талантливый вор, лучший из лучших в опасном искусстве извлечения: он крадёт ценные секреты из глубин подсознания во время сна, когда человеческий разум наиболее уязвим.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/447301.jpg',
  ),
  const Movie(
    id: 2,
    title: 'Интерстеллар',
    year: 2014,
    genre: 'Фантастика',
    durationMinutes: 169,
    rating: 8.6,
    description:
        'Когда засуха, пыльные бури и вымирание растений приводят человечество к продовольственному кризису, группа исследователей отправляется через червоточину в космосе в поисках нового дома.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/258687.jpg',
  ),
  const Movie(
    id: 3,
    title: 'Матрица',
    year: 1999,
    genre: 'Фантастика',
    durationMinutes: 136,
    rating: 8.7,
    description:
        'Хакер Нео узнаёт, что мир, в котором он живёт, — это компьютерная симуляция, созданная машинами для контроля над людьми. Он присоединяется к восстанию против машин.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/301.jpg',
  ),
  const Movie(
    id: 4,
    title: 'Бегущий по лезвию 2049',
    year: 2017,
    genre: 'Фантастика',
    durationMinutes: 164,
    rating: 8.0,
    description:
        'Офицер полиции Лос-Анджелеса по имени К раскрывает давно похороненный секрет, который может погрузить в хаос то, что осталось от цивилизации.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/589290.jpg',
  ),
  const Movie(
    id: 5,
    title: 'Дюна',
    year: 2021,
    genre: 'Фантастика',
    durationMinutes: 155,
    rating: 8.0,
    description:
        'Молодой Пол Атрейдес, гениальный и одарённый, рождённый для великих свершений, должен отправиться на самую опасную планету во Вселенной.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/409424.jpg',
  ),
  const Movie(
    id: 6,
    title: 'Прибытие',
    year: 2016,
    genre: 'Фантастика',
    durationMinutes: 116,
    rating: 7.9,
    description:
        'Когда на Земле приземляются загадочные инопланетные корабли, лингвист Луиза Бэнкс должна попытаться установить контакт с пришельцами.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/405654.jpg',
  ),

  // === БОЕВИК ===
  const Movie(
    id: 7,
    title: 'Тёмный рыцарь',
    year: 2008,
    genre: 'Боевик',
    durationMinutes: 152,
    rating: 9.0,
    description:
        'Бэтмен поднимает ставки в войне с криминалом. С помощью лейтенанта Джима Гордона и прокурора Харви Дента он намеревается очистить улицы Готэма от преступности.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/111543.jpg',
  ),
  const Movie(
    id: 8,
    title: 'Джон Уик',
    year: 2014,
    genre: 'Боевик',
    durationMinutes: 101,
    rating: 7.4,
    description:
        'После гибели любимой жены Джон Уик получает от неё последний подарок — щенка. Но сын главаря русской мафии убивает пса, не зная, что Джон — легендарный наёмный убийца.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/762738.jpg',
  ),
  const Movie(
    id: 9,
    title: 'Безумный Макс: Дорога ярости',
    year: 2015,
    genre: 'Боевик',
    durationMinutes: 120,
    rating: 8.1,
    description:
        'В мире после апокалипсиса Макс объединяется с Фуриосой, чтобы сбежать от тирана Несмертного Джо и его армии.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/537979.jpg',
  ),
  const Movie(
    id: 10,
    title: 'Гладиатор',
    year: 2000,
    genre: 'Боевик',
    durationMinutes: 155,
    rating: 8.5,
    description:
        'Римский генерал Максимус предан императором Коммодом и продан в рабство. Он становится гладиатором и жаждет мести.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/474.jpg',
  ),

  // === ДРАМА ===
  const Movie(
    id: 11,
    title: 'Побег из Шоушенка',
    year: 1994,
    genre: 'Драма',
    durationMinutes: 142,
    rating: 9.3,
    description:
        'Бухгалтер Энди Дюфрейн обвинён в убийстве жены и её любовника. Несмотря на то, что он невиновен, его приговаривают к пожизненному заключению в тюрьме Шоушенк.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/326.jpg',
  ),
  const Movie(
    id: 12,
    title: 'Форрест Гамп',
    year: 1994,
    genre: 'Драма',
    durationMinutes: 142,
    rating: 8.8,
    description:
        'История жизни Форреста Гампа, человека с низким IQ, который невольно становится свидетелем и участником ключевых событий американской истории.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/448.jpg',
  ),
  const Movie(
    id: 13,
    title: 'Зелёная миля',
    year: 1999,
    genre: 'Драма',
    durationMinutes: 189,
    rating: 8.6,
    description:
        'Пол Эджкомб — надзиратель в блоке смертников. Однажды в его блок привозят огромного чернокожего заключённого Джона Коффи, обладающего сверхъестественными способностями.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/435.jpg',
  ),
  const Movie(
    id: 14,
    title: 'Список Шиндлера',
    year: 1993,
    genre: 'Драма',
    durationMinutes: 195,
    rating: 9.0,
    description:
        'История немецкого бизнесмена Оскара Шиндлера, который спас более тысячи польских евреев во время Холокоста.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/329.jpg',
  ),
  const Movie(
    id: 15,
    title: 'Престиж',
    year: 2006,
    genre: 'Драма',
    durationMinutes: 130,
    rating: 8.5,
    description:
        'Два талантливых иллюзиониста ведут смертельное соперничество, пытаясь разгадать секрет лучшего фокуса друг друга.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/195334.jpg',
  ),

  // === ТРИЛЛЕР ===
  const Movie(
    id: 16,
    title: 'Молчание ягнят',
    year: 1991,
    genre: 'Триллер',
    durationMinutes: 118,
    rating: 8.6,
    description:
        'Молодая сотрудница ФБР Кларисса Старлинг обращается к заключённому маньяку-каннибалу за помощью в поимке другого серийного убийцы.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/345.jpg',
  ),
  const Movie(
    id: 17,
    title: 'Семь',
    year: 1995,
    genre: 'Триллер',
    durationMinutes: 127,
    rating: 8.6,
    description:
        'Два детектива расследуют серию убийств, совершённых по мотивам семи смертных грехов.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/342.jpg',
  ),
  const Movie(
    id: 18,
    title: 'Исчезнувшая',
    year: 2014,
    genre: 'Триллер',
    durationMinutes: 149,
    rating: 8.1,
    description:
        'В день пятой годовщины свадьбы Ник Данн сообщает о загадочном исчезновении своей жены Эми. Подозрение падает на самого Ника.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/730738.jpg',
  ),

  // === КОМЕДИЯ ===
  const Movie(
    id: 19,
    title: 'Большой Лебовски',
    year: 1998,
    genre: 'Комедия',
    durationMinutes: 117,
    rating: 8.1,
    description:
        'Безработный лентяй по прозвищу Чувак оказывается втянут в историю с похищением из-за путаницы с именами.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/4486.jpg',
  ),
  const Movie(
    id: 20,
    title: 'Криминальное чтиво',
    year: 1994,
    genre: 'Комедия',
    durationMinutes: 154,
    rating: 8.9,
    description:
        'Несколько связанных между собой историй из жизни гангстеров, боксёров и грабителей в Лос-Анджелесе.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/342.jpg',
  ),
  const Movie(
    id: 21,
    title: '1+1',
    year: 2011,
    genre: 'Комедия',
    durationMinutes: 112,
    rating: 8.5,
    description:
        'Аристократ-миллионер, ставший инвалидом после несчастного случая, берёт в помощники выходца из парижского гетто.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/535341.jpg',
  ),

  // === УЖАСЫ ===
  const Movie(
    id: 22,
    title: 'Сияние',
    year: 1980,
    genre: 'Ужасы',
    durationMinutes: 146,
    rating: 8.4,
    description:
        'Писатель Джек Торренс соглашается быть зимним смотрителем отеля "Оверлук". Вместе с семьёй он поселяется в отеле, который оказывается проклят.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/371.jpg',
  ),
  const Movie(
    id: 23,
    title: 'Прочь',
    year: 2017,
    genre: 'Ужасы',
    durationMinutes: 104,
    rating: 7.7,
    description:
        'Молодой афроамериканец едет знакомиться с семьёй своей белой девушки и обнаруживает, что там происходит нечто странное.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/865897.jpg',
  ),

  // === АНИМАЦИЯ ===
  const Movie(
    id: 24,
    title: 'ВАЛЛ·И',
    year: 2008,
    genre: 'Анимация',
    durationMinutes: 98,
    rating: 8.4,
    description:
        'Маленький робот-мусорщик ВАЛЛ·И остался один на опустевшей Земле и влюбляется в робота-разведчика ЕВУ.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/279102.jpg',
  ),
  const Movie(
    id: 25,
    title: 'Твоё имя',
    year: 2016,
    genre: 'Анимация',
    durationMinutes: 106,
    rating: 8.4,
    description:
        'Токийский парень Таки и деревенская девушка Мицуха обнаруживают, что они могут меняться телами во сне.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/942396.jpg',
  ),
  const Movie(
    id: 26,
    title: 'Унесённые призраками',
    year: 2001,
    genre: 'Анимация',
    durationMinutes: 125,
    rating: 8.6,
    description:
        'Десятилетняя Тихиро попадает в мир духов и должна работать в бане для богов, чтобы спасти своих родителей.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/370.jpg',
  ),

  // === ПРИКЛЮЧЕНИЯ ===
  const Movie(
    id: 27,
    title: 'Властелин колец: Возвращение короля',
    year: 2003,
    genre: 'Приключения',
    durationMinutes: 201,
    rating: 9.0,
    description:
        'Армии Саурона напали на Минас Тирит. Арагорн должен занять свой трон. Фродо и Сэм приближаются к Роковой горе.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/3498.jpg',
  ),
  const Movie(
    id: 28,
    title: 'Пираты Карибского моря: Проклятие Чёрной жемчужины',
    year: 2003,
    genre: 'Приключения',
    durationMinutes: 143,
    rating: 8.1,
    description:
        'Кузнец Уилл Тёрнер объединяется с эксцентричным пиратом Джеком Воробьём, чтобы спасти похищенную Элизабет Суонн.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/4374.jpg',
  ),
  const Movie(
    id: 29,
    title: 'Индиана Джонс: В поисках утраченного ковчега',
    year: 1981,
    genre: 'Приключения',
    durationMinutes: 115,
    rating: 8.4,
    description:
        'Археолог и искатель приключений Индиана Джонс отправляется на поиски Ковчега Завета раньше нацистов.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/8231.jpg',
  ),

  // === ДЕТЕКТИВ ===
  const Movie(
    id: 30,
    title: 'Достать ножи',
    year: 2019,
    genre: 'Детектив',
    durationMinutes: 130,
    rating: 7.9,
    description:
        'После смерти знаменитого автора детективов детектив Блан расследует обстоятельства гибели, опрашивая его эксцентричную семью.',
    posterUrl: 'https://st.kp.yandex.net/images/film_big/1143242.jpg',
  ),
];
