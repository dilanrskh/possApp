import 'package:possapp/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {
  ProductLocalDataSource._init();

  static final ProductLocalDataSource instance = ProductLocalDataSource._init();

  // bikin tabel produk
  final String tableProduct = 'produks';

  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // ini untuk membuat database dan tabel nya

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProduct (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          harga INTEGER,
          stock INTEGER,
          image TEXT,
          category TEXT
          )
        ''');
  }

  // ini untuk get Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posapp.db');
    return _database!;
  }

  // Remove all product
  Future<void> removeAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProduct);
  }

  // Insert data produk
  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toJson());
    }
  }

  // Get All data produk dari lokal
  Future<List<Product>> getAllProduct() async {
    final db = await instance.database;
    final result = await db.query(tableProduct);
    return result.map((e) => Product.fromJson(e)).toList();
  }
}
