import 'dart:convert';

import 'package:dartz/dartz.dart';
import "package:http/http.dart" as http;
import 'package:possapp/core/constants/variables.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/models/request/product_request_model.dart';
import 'package:possapp/data/models/response/add_product_response_model.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

class ProductRemoteDataSource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return right(ProductResponseModel.fromJson(json.decode(response.body)));
      } else {
        return left('Failed to load products');
      }
    } catch (e) {
      return left('An error occurred: $e');
    }
  }

  // Create Produk
  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Variables.baseUrl}/api/products'));

      request.fields.addAll(productRequestModel.toMap());

      request.files.add(await http.MultipartFile.fromPath(
          'image', productRequestModel.image.path));

      http.StreamedResponse response = await request.send();

      final String body = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return Right(AddProductResponseModel.fromJson(json.decode(body)));
      } else {
        return Left(
            'Gagal tambah produk karena ${response.statusCode}');
      }
    } catch (e) {
      return Left('Gagal tambah produk: $e');
    }
  }
}
