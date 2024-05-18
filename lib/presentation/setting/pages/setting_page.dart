import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possapp/core/assets/assets.gen.dart';
import 'package:possapp/core/components/menu_button.dart';
import 'package:possapp/core/components/spaces.dart';
import 'package:possapp/core/constants/colors.dart';
import 'package:possapp/core/extensions/build_context_ext.dart';
import 'package:possapp/data/datasources/auth_local_datasource.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/presentation/auth/pages/login_page.dart';
import 'package:possapp/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:possapp/presentation/home/bloc/product/product_bloc.dart';
import 'package:possapp/presentation/orders/models/order_models.dart';
import 'package:possapp/presentation/setting/pages/manage_product_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              MenuButton(
                iconPath: Assets.images.manageProduct.path,
                label: 'Kelola Produk',
                onPressed: () => context.push(const ManageProductPage()),
                isImage: true,
              ),
              const SpaceWidth(15.0),
              MenuButton(
                iconPath: Assets.images.managePrinter.path,
                label: 'Kelola Printer',
                onPressed: () {}, //=> context.push(const ManagePrinterPage()),
                isImage: true,
              ),
            ],
          ),
          const SpaceHeight(60),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) async {
                  await ProductLocalDatasource.instance.removeAllProduct();
                  await ProductLocalDatasource.instance
                      .insertAllProduct(_.products.toList());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.primary,
                      content: Text(
                        "Sync Data Success",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              // Harusnya ketika proses async atau ambil data, dia reload
              return state.maybeWhen(
                orElse: () {
                  return ElevatedButton(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(const ProductEvent.fetch());
                      },
                      child: const Text('Sync Data'));
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
          const Divider(),
          // icon button di ganti jadi bloc consumer, biar nanti kalau logout, dia bisa pindah ke halaman login atau ke yang dimau
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  // Ini buat pas logout, bakal nge remove data sama nge hapus token
                  AuthLocalDataSource().removeAuthData();
                  // replacement biar kalau nge back, bakal balik ke awal, bukan balik ke tumpukan belakang
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              );
            },
            // dibuilder bakal mengembalikan widget
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                child: const Text('Logout'),
              );
            },
          ),
          const Divider(),
          FutureBuilder<List<OrderModel>>(
              future: ProductLocalDatasource.instance.getOrderByIsSync(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data![index].nominalBayar.toString()),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              })
        ],
      ),
    );
  }
}