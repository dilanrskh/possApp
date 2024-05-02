class ProductResponseModel {
  final bool status;
  final List<Product> data;

  ProductResponseModel({
    required this.status,
    required this.data,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      status: json['status'],
      data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  final int id;
  final String name;
  final String deskripsi;
  final int harga;
  final int stock;
  final String category;
  final String image;
  final String tanggalTambahProduk;

  Product({
    required this.id,
    required this.name,
    required this.deskripsi,
    required this.harga,
    required this.stock,
    required this.category,
    required this.image,
    required this.tanggalTambahProduk,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      deskripsi: json['deskripsi'] ?? '',
      harga: json['harga'],
      stock: json['stock'],
      category: json['category'],
      image: json['image'] ?? '',
      tanggalTambahProduk: json['tanggal_tambah_produk'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'deskripsi': deskripsi,
    'harga': harga,
    'stock': stock,
    'category': category,
    'image': image,
    'tanggal_tambah_produk': tanggalTambahProduk,
  };
}