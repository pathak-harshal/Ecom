// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecom_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorEcomDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EcomDatabaseBuilder databaseBuilder(String name) =>
      _$EcomDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EcomDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EcomDatabaseBuilder(null);
}

class _$EcomDatabaseBuilder {
  _$EcomDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$EcomDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EcomDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EcomDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$EcomDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EcomDatabase extends EcomDatabase {
  _$EcomDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao _categoryDaoInstance;

  ParentCategoryDao _parentCategoryDaoInstance;

  ProductDao _productDaoInstance;

  VariantDao _variantDaoInstance;

  RankingDao _rankingDaoInstance;

  ProductsRankingDao _productsRankingDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `category` (`category_id` INTEGER, `category_name` TEXT NOT NULL, `parent_also` INTEGER NOT NULL, `parent_id` INTEGER, PRIMARY KEY (`category_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `parent_category` (`parent_category_id` INTEGER, `category_name` TEXT NOT NULL, PRIMARY KEY (`parent_category_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `product` (`product_id` INTEGER, `product_name` TEXT, `product_date_added` TEXT, `category_id` INTEGER, `tax_name` TEXT, `tax_value` REAL, PRIMARY KEY (`product_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `variant` (`variant_id` INTEGER, `variant_color` TEXT NOT NULL, `variant_size` INTEGER, `variant_price` INTEGER, `product_id` INTEGER, PRIMARY KEY (`variant_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rankings` (`ranking_text` TEXT, PRIMARY KEY (`ranking_text`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `products_ranking` (`ranking_text` TEXT, `product_id` INTEGER, `total_count` INTEGER, PRIMARY KEY (`ranking_text`, `product_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  ParentCategoryDao get parentCategoryDao {
    return _parentCategoryDaoInstance ??=
        _$ParentCategoryDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  VariantDao get variantDao {
    return _variantDaoInstance ??= _$VariantDao(database, changeListener);
  }

  @override
  RankingDao get rankingDao {
    return _rankingDaoInstance ??= _$RankingDao(database, changeListener);
  }

  @override
  ProductsRankingDao get productsRankingDao {
    return _productsRankingDaoInstance ??=
        _$ProductsRankingDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (CategoryEntity item) => <String, dynamic>{
                  'category_id': item.categoryId,
                  'category_name': item.categoryName,
                  'parent_also': item.isParentAlso ? 1 : 0,
                  'parent_id': item.parentId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _categoryMapper = (Map<String, dynamic> row) => CategoryEntity(
      categoryId: row['category_id'] as int,
      categoryName: row['category_name'] as String,
      isParentAlso: (row['parent_also'] as int) != 0,
      parentId: row['parent_id'] as int);

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  @override
  Stream<List<CategoryEntity>> findAllCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        queryableName: 'category', isView: false, mapper: _categoryMapper);
  }

  @override
  Future<List<CategoryEntity>> findAllCategoryList() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: _categoryMapper);
  }

  @override
  Future<void> insertCategories(List<CategoryEntity> categories) async {
    await _categoryEntityInsertionAdapter.insertList(
        categories, OnConflictStrategy.replace);
  }
}

class _$ParentCategoryDao extends ParentCategoryDao {
  _$ParentCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _parentCategoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'parent_category',
            (ParentCategoryEntity item) => <String, dynamic>{
                  'parent_category_id': item.parentCategoryId,
                  'category_name': item.parentCategoryName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _parent_categoryMapper = (Map<String, dynamic> row) =>
      ParentCategoryEntity(
          parentCategoryId: row['parent_category_id'] as int,
          parentCategoryName: row['category_name'] as String);

  final InsertionAdapter<ParentCategoryEntity>
      _parentCategoryEntityInsertionAdapter;

  @override
  Stream<List<ParentCategoryEntity>> findAllParentCategories() {
    return _queryAdapter.queryListStream('SELECT * FROM parent_category',
        queryableName: 'parent_category',
        isView: false,
        mapper: _parent_categoryMapper);
  }

  @override
  Future<List<ParentCategoryEntity>> findAllParentCategoryList() async {
    return _queryAdapter.queryList('SELECT * FROM parent_category',
        mapper: _parent_categoryMapper);
  }

  @override
  Future<void> insertParentCategories(
      List<ParentCategoryEntity> parentCategories) async {
    await _parentCategoryEntityInsertionAdapter.insertList(
        parentCategories, OnConflictStrategy.replace);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'product',
            (ProductEntity item) => <String, dynamic>{
                  'product_id': item.productId,
                  'product_name': item.productName,
                  'product_date_added': item.productDateAdded,
                  'category_id': item.categoryId,
                  'tax_name': item.taxName,
                  'tax_value': item.taxValue
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _productMapper = (Map<String, dynamic> row) => ProductEntity(
      productId: row['product_id'] as int,
      productName: row['product_name'] as String,
      productDateAdded: row['product_date_added'] as String,
      categoryId: row['category_id'] as int,
      taxName: row['tax_name'] as String,
      taxValue: row['tax_value'] as double);

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  @override
  Stream<List<ProductEntity>> findAllProducts() {
    return _queryAdapter.queryListStream('SELECT * FROM product',
        queryableName: 'product', isView: false, mapper: _productMapper);
  }

  @override
  Future<List<ProductEntity>> findAllProductList() async {
    return _queryAdapter.queryList('SELECT * FROM product',
        mapper: _productMapper);
  }

  @override
  Future<void> insertProducts(List<ProductEntity> products) async {
    await _productEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.replace);
  }
}

class _$VariantDao extends VariantDao {
  _$VariantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _variantEntityInsertionAdapter = InsertionAdapter(
            database,
            'variant',
            (VariantEntity item) => <String, dynamic>{
                  'variant_id': item.variantId,
                  'variant_color': item.variantColor,
                  'variant_size': item.variantSize,
                  'variant_price': item.variantPrice,
                  'product_id': item.productId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _variantMapper = (Map<String, dynamic> row) => VariantEntity(
      variantId: row['variant_id'] as int,
      variantColor: row['variant_color'] as String,
      variantSize: row['variant_size'] as int,
      variantPrice: row['variant_price'] as int,
      productId: row['product_id'] as int);

  final InsertionAdapter<VariantEntity> _variantEntityInsertionAdapter;

  @override
  Stream<List<VariantEntity>> findAllVariants() {
    return _queryAdapter.queryListStream('SELECT * FROM variant',
        queryableName: 'variant', isView: false, mapper: _variantMapper);
  }

  @override
  Future<List<VariantEntity>> findAllVariantList() async {
    return _queryAdapter.queryList('SELECT * FROM variant',
        mapper: _variantMapper);
  }

  @override
  Future<void> insertVariants(List<VariantEntity> variants) async {
    await _variantEntityInsertionAdapter.insertList(
        variants, OnConflictStrategy.replace);
  }
}

class _$RankingDao extends RankingDao {
  _$RankingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _rankingEntityInsertionAdapter = InsertionAdapter(
            database,
            'rankings',
            (RankingEntity item) =>
                <String, dynamic>{'ranking_text': item.rankingText},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _rankingsMapper = (Map<String, dynamic> row) =>
      RankingEntity(rankingText: row['ranking_text'] as String);

  final InsertionAdapter<RankingEntity> _rankingEntityInsertionAdapter;

  @override
  Stream<List<RankingEntity>> findAllRakings() {
    return _queryAdapter.queryListStream('SELECT * FROM rankings',
        queryableName: 'rankings', isView: false, mapper: _rankingsMapper);
  }

  @override
  Future<List<RankingEntity>> findAllRankingList() async {
    return _queryAdapter.queryList('SELECT * FROM rankings',
        mapper: _rankingsMapper);
  }

  @override
  Future<int> insertRanking(RankingEntity rankingEntity) {
    return _rankingEntityInsertionAdapter.insertAndReturnId(
        rankingEntity, OnConflictStrategy.replace);
  }
}

class _$ProductsRankingDao extends ProductsRankingDao {
  _$ProductsRankingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _productsRankingEntityInsertionAdapter = InsertionAdapter(
            database,
            'products_ranking',
            (ProductsRankingEntity item) => <String, dynamic>{
                  'ranking_text': item.rankingText,
                  'product_id': item.productId,
                  'total_count': item.totalCount
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _products_rankingMapper = (Map<String, dynamic> row) =>
      ProductsRankingEntity(
          rankingText: row['ranking_text'] as String,
          productId: row['product_id'] as int,
          totalCount: row['total_count'] as int);

  final InsertionAdapter<ProductsRankingEntity>
      _productsRankingEntityInsertionAdapter;

  @override
  Stream<List<ProductsRankingEntity>> findAllProductRankings() {
    return _queryAdapter.queryListStream('SELECT * FROM products_ranking',
        queryableName: 'products_ranking',
        isView: false,
        mapper: _products_rankingMapper);
  }

  @override
  Future<List<ProductsRankingEntity>> findAllProductRankingList() async {
    return _queryAdapter.queryList('SELECT * FROM products_ranking',
        mapper: _products_rankingMapper);
  }

  @override
  Future<void> insertProductRankings(
      List<ProductsRankingEntity> productsRanking) async {
    await _productsRankingEntityInsertionAdapter.insertList(
        productsRanking, OnConflictStrategy.replace);
  }
}
