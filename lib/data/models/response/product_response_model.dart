// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final int? id;
  final String name;
  final String? deskripsi;
  final int harga;
  final int stock;
  final String category;
  final String image;
  final bool isBestSeller;
  final String? tanggalTambahProduk;

  Product({
    this.id,
    required this.name,
    this.deskripsi,
    required this.harga,
    required this.stock,
    required this.category,
    required this.image,
    this.tanggalTambahProduk,
    this.isBestSeller = false,
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
      isBestSeller: json['is_best_seller'] == 1 ? true : false,
      // tanggalTambahProduk: json['tanggal_tambah_produk'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'harga': harga,
    'stock': stock,
    'category': category,
    'image': image,
    'is_best_seller': isBestSeller ? 1 : 0,
  };

  Product copyWith({
    int? id,
    String? name,
    String? deskripsi,
    int? harga,
    int? stock,
    String? category,
    String? image,
    bool? isBestSeller,
    String? tanggalTambahProduk,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      deskripsi: deskripsi ?? this.deskripsi,
      harga: harga ?? this.harga,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      image: image ?? this.image,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      tanggalTambahProduk: tanggalTambahProduk ?? this.tanggalTambahProduk,
    );
  }
}
