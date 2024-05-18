// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:possapp/core/extensions/int_ext.dart';
import 'package:possapp/presentation/home/models/order_item.dart';

class OrderModel {
  final String paymentMethod;
  final int nominalBayar;
  final List<OrderItem> orders;
  final int totalQuantity;
  final int totalPrice;
  final int idKasir;
  final String namaKasir;
  final bool isSync;

  OrderModel({
    required this.paymentMethod,
    required this.nominalBayar,
    required this.orders,
    required this.totalQuantity,
    required this.totalPrice,
    required this.idKasir,
    required this.namaKasir,
    required this.isSync,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'nominalBayar': nominalBayar,
      'orders': orders.map((x) => x.toMap()).toList(),
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'idKasir': idKasir,
      'namaKasir': namaKasir,
      'isSync': isSync,
    };
  }

  //       nominal INTEGER,
  //       payment_method TEXT,
  //       total_item INTEGER,
  //       id_kasir INTEGER,
  //       nama_kasir TEXT,
  //       is_sync INTEGER DEFAULT 0

  Map<String, dynamic> toMapForLocal() {
    return {
      'payment_method': paymentMethod,
      'total_item': totalQuantity,
      'nominal': totalPrice,
      'id_kasir': idKasir,
      'nama_kasir': namaKasir,
      'is_sync': isSync ? 1 : 0,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['paymentMethod'] as String,
      nominalBayar: map['nominalBayar'] as int,
      orders: List<OrderItem>.from((map['orders'] as List<int>).map<OrderItem>((x) => OrderItem.fromMap(x as Map<String,dynamic>),),),
      totalQuantity: map['totalQuantity'] as int,
      totalPrice: map['totalPrice'] as int,
      idKasir: map['idKasir'] as int,
      namaKasir: map['namaKasir'] as String,
      isSync: map['isSync'] as bool,
    );
  }

  
  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['payment_method'] ?? '',
      nominalBayar: map['nominal'] ?? 0,
      orders: [],
      totalQuantity: map['total_item'] ?? 0,
      totalPrice: map['nominal'] ?? 0,
      idKasir: map['id_kasir'] ?? 0,
      namaKasir: map['nama_kasir'] ?? '',
      isSync: map['is_sync'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
