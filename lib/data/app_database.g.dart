// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MoviesTable extends Movies with TableInfo<$MoviesTable, Movy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _posterMeta = const VerificationMeta('poster');
  @override
  late final GeneratedColumn<Uint8List> poster = GeneratedColumn<Uint8List>(
    'poster',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posterAssetPathMeta = const VerificationMeta(
    'posterAssetPath',
  );
  @override
  late final GeneratedColumn<String> posterAssetPath = GeneratedColumn<String>(
    'poster_asset_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Movy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('poster')) {
      context.handle(
        _posterMeta,
        poster.isAcceptableOrUnknown(data['poster']!, _posterMeta),
      );
    }
    if (data.containsKey('poster_asset_path')) {
      context.handle(
        _posterAssetPathMeta,
        posterAssetPath.isAcceptableOrUnknown(
          data['poster_asset_path']!,
          _posterAssetPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Movy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Movy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      poster: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}poster'],
      ),
      posterAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}poster_asset_path'],
      ),
    );
  }

  @override
  $MoviesTable createAlias(String alias) {
    return $MoviesTable(attachedDatabase, alias);
  }
}

class Movy extends DataClass implements Insertable<Movy> {
  final int id;
  final String title;
  final int year;
  final String genre;
  final int durationMinutes;
  final double rating;
  final String description;
  final Uint8List? poster;
  final String? posterAssetPath;
  const Movy({
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['year'] = Variable<int>(year);
    map['genre'] = Variable<String>(genre);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['rating'] = Variable<double>(rating);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || poster != null) {
      map['poster'] = Variable<Uint8List>(poster);
    }
    if (!nullToAbsent || posterAssetPath != null) {
      map['poster_asset_path'] = Variable<String>(posterAssetPath);
    }
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      title: Value(title),
      year: Value(year),
      genre: Value(genre),
      durationMinutes: Value(durationMinutes),
      rating: Value(rating),
      description: Value(description),
      poster: poster == null && nullToAbsent
          ? const Value.absent()
          : Value(poster),
      posterAssetPath: posterAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(posterAssetPath),
    );
  }

  factory Movy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movy(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      year: serializer.fromJson<int>(json['year']),
      genre: serializer.fromJson<String>(json['genre']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      rating: serializer.fromJson<double>(json['rating']),
      description: serializer.fromJson<String>(json['description']),
      poster: serializer.fromJson<Uint8List?>(json['poster']),
      posterAssetPath: serializer.fromJson<String?>(json['posterAssetPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'year': serializer.toJson<int>(year),
      'genre': serializer.toJson<String>(genre),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'rating': serializer.toJson<double>(rating),
      'description': serializer.toJson<String>(description),
      'poster': serializer.toJson<Uint8List?>(poster),
      'posterAssetPath': serializer.toJson<String?>(posterAssetPath),
    };
  }

  Movy copyWith({
    int? id,
    String? title,
    int? year,
    String? genre,
    int? durationMinutes,
    double? rating,
    String? description,
    Value<Uint8List?> poster = const Value.absent(),
    Value<String?> posterAssetPath = const Value.absent(),
  }) => Movy(
    id: id ?? this.id,
    title: title ?? this.title,
    year: year ?? this.year,
    genre: genre ?? this.genre,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    rating: rating ?? this.rating,
    description: description ?? this.description,
    poster: poster.present ? poster.value : this.poster,
    posterAssetPath: posterAssetPath.present
        ? posterAssetPath.value
        : this.posterAssetPath,
  );
  Movy copyWithCompanion(MoviesCompanion data) {
    return Movy(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      year: data.year.present ? data.year.value : this.year,
      genre: data.genre.present ? data.genre.value : this.genre,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      rating: data.rating.present ? data.rating.value : this.rating,
      description: data.description.present
          ? data.description.value
          : this.description,
      poster: data.poster.present ? data.poster.value : this.poster,
      posterAssetPath: data.posterAssetPath.present
          ? data.posterAssetPath.value
          : this.posterAssetPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Movy(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('genre: $genre, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('rating: $rating, ')
          ..write('description: $description, ')
          ..write('poster: $poster, ')
          ..write('posterAssetPath: $posterAssetPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    year,
    genre,
    durationMinutes,
    rating,
    description,
    $driftBlobEquality.hash(poster),
    posterAssetPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movy &&
          other.id == this.id &&
          other.title == this.title &&
          other.year == this.year &&
          other.genre == this.genre &&
          other.durationMinutes == this.durationMinutes &&
          other.rating == this.rating &&
          other.description == this.description &&
          $driftBlobEquality.equals(other.poster, this.poster) &&
          other.posterAssetPath == this.posterAssetPath);
}

class MoviesCompanion extends UpdateCompanion<Movy> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> year;
  final Value<String> genre;
  final Value<int> durationMinutes;
  final Value<double> rating;
  final Value<String> description;
  final Value<Uint8List?> poster;
  final Value<String?> posterAssetPath;
  const MoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.year = const Value.absent(),
    this.genre = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.rating = const Value.absent(),
    this.description = const Value.absent(),
    this.poster = const Value.absent(),
    this.posterAssetPath = const Value.absent(),
  });
  MoviesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int year,
    required String genre,
    required int durationMinutes,
    required double rating,
    required String description,
    this.poster = const Value.absent(),
    this.posterAssetPath = const Value.absent(),
  }) : title = Value(title),
       year = Value(year),
       genre = Value(genre),
       durationMinutes = Value(durationMinutes),
       rating = Value(rating),
       description = Value(description);
  static Insertable<Movy> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? year,
    Expression<String>? genre,
    Expression<int>? durationMinutes,
    Expression<double>? rating,
    Expression<String>? description,
    Expression<Uint8List>? poster,
    Expression<String>? posterAssetPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (year != null) 'year': year,
      if (genre != null) 'genre': genre,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (rating != null) 'rating': rating,
      if (description != null) 'description': description,
      if (poster != null) 'poster': poster,
      if (posterAssetPath != null) 'poster_asset_path': posterAssetPath,
    });
  }

  MoviesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? year,
    Value<String>? genre,
    Value<int>? durationMinutes,
    Value<double>? rating,
    Value<String>? description,
    Value<Uint8List?>? poster,
    Value<String?>? posterAssetPath,
  }) {
    return MoviesCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (poster.present) {
      map['poster'] = Variable<Uint8List>(poster.value);
    }
    if (posterAssetPath.present) {
      map['poster_asset_path'] = Variable<String>(posterAssetPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('genre: $genre, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('rating: $rating, ')
          ..write('description: $description, ')
          ..write('poster: $poster, ')
          ..write('posterAssetPath: $posterAssetPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MoviesTable movies = $MoviesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movies];
}

typedef $$MoviesTableCreateCompanionBuilder =
    MoviesCompanion Function({
      Value<int> id,
      required String title,
      required int year,
      required String genre,
      required int durationMinutes,
      required double rating,
      required String description,
      Value<Uint8List?> poster,
      Value<String?> posterAssetPath,
    });
typedef $$MoviesTableUpdateCompanionBuilder =
    MoviesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> year,
      Value<String> genre,
      Value<int> durationMinutes,
      Value<double> rating,
      Value<String> description,
      Value<Uint8List?> poster,
      Value<String?> posterAssetPath,
    });

class $$MoviesTableFilterComposer
    extends Composer<_$AppDatabase, $MoviesTable> {
  $$MoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get poster => $composableBuilder(
    column: $table.poster,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get posterAssetPath => $composableBuilder(
    column: $table.posterAssetPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MoviesTableOrderingComposer
    extends Composer<_$AppDatabase, $MoviesTable> {
  $$MoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get poster => $composableBuilder(
    column: $table.poster,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get posterAssetPath => $composableBuilder(
    column: $table.posterAssetPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoviesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoviesTable> {
  $$MoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get poster =>
      $composableBuilder(column: $table.poster, builder: (column) => column);

  GeneratedColumn<String> get posterAssetPath => $composableBuilder(
    column: $table.posterAssetPath,
    builder: (column) => column,
  );
}

class $$MoviesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MoviesTable,
          Movy,
          $$MoviesTableFilterComposer,
          $$MoviesTableOrderingComposer,
          $$MoviesTableAnnotationComposer,
          $$MoviesTableCreateCompanionBuilder,
          $$MoviesTableUpdateCompanionBuilder,
          (Movy, BaseReferences<_$AppDatabase, $MoviesTable, Movy>),
          Movy,
          PrefetchHooks Function()
        > {
  $$MoviesTableTableManager(_$AppDatabase db, $MoviesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String> genre = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<Uint8List?> poster = const Value.absent(),
                Value<String?> posterAssetPath = const Value.absent(),
              }) => MoviesCompanion(
                id: id,
                title: title,
                year: year,
                genre: genre,
                durationMinutes: durationMinutes,
                rating: rating,
                description: description,
                poster: poster,
                posterAssetPath: posterAssetPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int year,
                required String genre,
                required int durationMinutes,
                required double rating,
                required String description,
                Value<Uint8List?> poster = const Value.absent(),
                Value<String?> posterAssetPath = const Value.absent(),
              }) => MoviesCompanion.insert(
                id: id,
                title: title,
                year: year,
                genre: genre,
                durationMinutes: durationMinutes,
                rating: rating,
                description: description,
                poster: poster,
                posterAssetPath: posterAssetPath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoviesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MoviesTable,
      Movy,
      $$MoviesTableFilterComposer,
      $$MoviesTableOrderingComposer,
      $$MoviesTableAnnotationComposer,
      $$MoviesTableCreateCompanionBuilder,
      $$MoviesTableUpdateCompanionBuilder,
      (Movy, BaseReferences<_$AppDatabase, $MoviesTable, Movy>),
      Movy,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MoviesTableTableManager get movies =>
      $$MoviesTableTableManager(_db, _db.movies);
}
