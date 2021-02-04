// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_data_base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorMainDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MainDataBaseBuilder databaseBuilder(String name) =>
      _$MainDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MainDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$MainDataBaseBuilder(null);
}

class _$MainDataBaseBuilder {
  _$MainDataBaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$MainDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MainDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MainDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$MainDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MainDataBase extends MainDataBase {
  _$MainDataBase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StoreDao _storeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cart_product` (`id` TEXT NOT NULL, `title` TEXT, `description` TEXT, `price` REAL, `imageUrl` TEXT, `is_fav` INTEGER, `user_id` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StoreDao get storeDao {
    return _storeDaoInstance ??= _$StoreDao(database, changeListener);
  }
}

class _$StoreDao extends StoreDao {
  _$StoreDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'cart_product',
            (Product item) =>
            <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'price': item.price,
                  'imageUrl': item.imageUrl,
                  'is_fav': item.is_fav == null ? null : (item.is_fav ? 1 : 0),
                  'user_id': item.user_id
                }),
        _productDeletionAdapter = DeletionAdapter(
            database,
            'cart_product',
            ['id'],
            (Product item) =>
            <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'price': item.price,
                  'imageUrl': item.imageUrl,
                  'is_fav': item.is_fav == null ? null : (item.is_fav ? 1 : 0),
                  'user_id': item.user_id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Product> _productInsertionAdapter;

  final DeletionAdapter<Product> _productDeletionAdapter;

  @override
  Future<List<Product>> getAllCarItem() async {
    return _queryAdapter.queryList('select * from cart_product',
        mapper: (Map<String, dynamic> row) => Product(
            id: row['id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            price: row['price'] as double,
            imageUrl: row['imageUrl'] as String,
            is_fav: row['is_fav'] == null ? null : (row['is_fav'] as int) != 0,
            user_id: row['user_id'] as String));
  }

  @override
  Future<Product> getCartItemById(String id) async {
    return _queryAdapter.query(
        'select * from cart_product where cart_product.id=?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Product(
            id: row['id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            price: row['price'] as double,
            imageUrl: row['imageUrl'] as String,
            is_fav: row['is_fav'] == null ? null : (row['is_fav'] as int) != 0,
            user_id: row['user_id'] as String));
  }

  @override
  Future<int> addItemtoCart(Product product) {
    return _productInsertionAdapter.insertAndReturnId(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<int> reoveCartItemById(Product product) {
    return _productDeletionAdapter.deleteAndReturnChangedRows(product);
  }
}
