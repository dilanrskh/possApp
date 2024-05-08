// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/data/datasources/product_remote_datasource.dart';
import 'package:possapp/data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDataSource _productRemoteDataSource;
  // Untuk Ambil data produk
  List<Product> products = [];
  ProductBloc(
    this._productRemoteDataSource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemoteDataSource.getProduct();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    // Ini untuk Fetch Data Lokal
    on<_FetchLocal>((event, emit) async {
      final localProducts = await ProductLocalDatasource.instance.getAllProduct();
      products = localProducts;
      emit(ProductState.success(products));
    });

    // Ini untuk filter data berdasarkan kategori
    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();

              emit(ProductState.success(newProduct));
    });

    on<_AddProduct>((event, emit) async {
      emit(const ProductState.loading());
      final newProduct = await ProductLocalDatasource.instance.insertProduct(event.product);
      products.add(newProduct);

      emit(ProductState.success(products));
    });
  }
}
