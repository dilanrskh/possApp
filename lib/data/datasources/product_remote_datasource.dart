import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:possapp/core/constants/variables.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

class ProductRemoteDataSource {
  Future<Either<String, ProductResponseModel>> getProduct() async {
    try {
      final authData = await AuthLocalDataSource()
      .getAuthData();
      final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/produk-api'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        return right(ProductResponseModel
        .fromJson(json.decode(response.body)));
      } else {
        return left('Failed to load products');
      }
    } catch (e) {
      return left('An error occurred: $e');
    }
  }
}