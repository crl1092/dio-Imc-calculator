// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FroomGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FroomAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(path, _migrations, _callback);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ImcDao? _imcDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `Imc` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `peso` REAL NOT NULL, `altura` REAL NOT NULL, `imc` REAL NOT NULL, `classificacao` TEXT NOT NULL)',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ImcDao get imcDao {
    return _imcDaoInstance ??= _$ImcDao(database, changeListener);
  }
}

class _$ImcDao extends ImcDao {
  _$ImcDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database, changeListener),
      _imcInsertionAdapter = InsertionAdapter(
        database,
        'Imc',
        (Imc item) => <String, Object?>{
          'id': item.id,
          'peso': item.peso,
          'altura': item.altura,
          'imc': item.imc,
          'classificacao': item.classificacao,
        },
        changeListener,
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Imc> _imcInsertionAdapter;

  @override
  Future<List<Imc>> getAll() async {
    return _queryAdapter.queryList(
      'SELECT * FROM Imc',
      mapper: (Map<String, Object?> row) => Imc(
        row['id'] as int,
        row['peso'] as double,
        row['altura'] as double,
        row['imc'] as double,
        row['classificacao'] as String,
      ),
    );
  }

  @override
  Stream<List<Imc>> watchAll() {
    return _queryAdapter.queryListStream(
      'SELECT * FROM Imc',
      mapper: (Map<String, Object?> row) => Imc(
        row['id'] as int,
        row['peso'] as double,
        row['altura'] as double,
        row['imc'] as double,
        row['classificacao'] as String,
      ),
      queryableName: 'Imc',
      isView: false,
    );
  }

  @override
  Future<void> insertImc(Imc imc) async {
    await _imcInsertionAdapter.insert(imc, OnConflictStrategy.replace);
  }
}
