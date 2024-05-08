import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/components/buttins.dart';
import 'package:possapp/core/components/custom_dropdown.dart';
import 'package:possapp/core/components/custom_text_field.dart';
import 'package:possapp/core/components/image_picker_widget.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/extensions/string_ext.dart';
import 'package:possapp/data/models/response/product_response_model.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/setting/models/category_models.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? stockController;
  String category = 'food';
  File? imageFile;
  bool isBestSeller = false;

  final List<CategoryModel> categories = [
    CategoryModel(name: 'Minuman', value: 'drink'),
    CategoryModel(name: 'Makanan', value: 'food'),
    CategoryModel(name: 'Snack', value: 'snack'),
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();
    stockController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    priceController!.dispose();
    stockController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Produk',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: nameController!,
            label: 'Nama Produk',
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: priceController!,
            label: 'Harga Produk',
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),
          const SpaceHeight(20.0),
          ImagePickerWidget(
            label: 'Foto Produk',
            onChanged: (file) {},
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: stockController!,
            label: 'Stock Produk',
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),
          const SpaceHeight(20.0),
          CustomDropdown<CategoryModel>(
            value: categories.first,
            items: categories,
            label: 'Kategori Produk',
            onChanged: (value) {
              category = value!.value;
            },
          ),
          const SpaceHeight(24.0),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (_) {
                    Navigator.pop(context);
                  });
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, success: (_) {
                return Button.filled(
                  onPressed: () {
                    final String name = nameController!.text;
                    final int price = priceController!.text.toIntegerFromText;
                    final int stock = stockController!.text.toIntegerFromText;
                    final Product product = Product(
                      name: name,
                      harga: price,
                      stock: stock,
                      category: category,
                      image: imageFile!.absolute.path,
                    );
                    context
                        .read<ProductBloc>()
                        .add(ProductEvent.addProduct(product));
                  },
                  label: 'Simpan',
                );
              });
            },
          ),
          const SpaceHeight(30.0),
          Button.outlined(
            onPressed: () {
              Navigator.pop(context);
            },
            label: 'Batal',
          ),
          const SpaceHeight(30.0),
        ],
      ),
    );
  }
}
