import 'package:possapp/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  // bikin tabel produk

  final String tableProducts = 'produks';

  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProducts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        harga INTEGER,
        stock INTEGER,
        image TEXT,
        category TEXT,
        is_best_seller INTEGER,
        is_sync INTEGER DEFAULT 0)
      ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posapp15.db');
    return _database!;
  }

  // remove all data product
  Future<void> removeAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  // tambah data produk
  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProducts, product.toJson());
    }
  }

  // Add single data produk
  Future<Product> insertProduct(Product product) async {
    final db = await instance.database;
    int id = await db.insert(tableProducts, product.toJson());
    return product.copyWith(id: id);
  }

  // Get all data produk dari lokal
  Future<List<Product>> getAllProduct() async {
    final db = await instance.database;
    final result = await db.query(tableProducts);
    return result.map((e) => Product.fromJson(e)).toList();
  }
}
