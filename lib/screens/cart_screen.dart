import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';
import '../utils/app_theme.dart';
import '../utils/routes.dart';

class CartScreen extends StatelessWidget {
  final List<List<String>> args;
  const CartScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CartCubit(organicImage: args[0], reusableImage: args[1]),
        child: CartView(args: args)
    );
  }
}


class CartView extends StatefulWidget {

  final List<List<String>> args;

  const CartView({Key? key, required this.args}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with SingleTickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black87,
            title: const Text('Keranjang Sampah'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            bottom: TabBar(
              controller: _controller,
              labelColor: Colors.black87,
              indicatorColor: Colors.black87,
              tabs: const [
                Tab(text: 'Organik',),
                Tab(text: 'Daur Ulang',),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              _CartView(images: state.organicImage, isOrganic: true,),
              _CartView(images: state.reusableImage, isOrganic: false),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.colorPrimary,
            onPressed: () {
              print(state.organicImage);
              print(state.reusableImage);
              if (state.organicImage.isNotEmpty && _controller.index == 0) {
                _navigateToMap(context, _controller.index);
              } else if (state.reusableImage.isNotEmpty && _controller.index == 1) {
                _navigateToMap(context, _controller.index);
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Tidak ada sampah'),
                    ),
                  );
              }
            },
            child: const Icon(Icons.search),
          ),
        );
      }
    );
  }

  void _navigateToMap(BuildContext context, int index) async {
    if (_controller.index == 0) {
      var arg = ScreenArguments<Map<String, dynamic>>({
        'garbageCollector': true,
        'garbageSize': widget.args[0].length,
      });
      final result = await Navigator.pushNamed(context, Routes.collectorMapScreen, arguments: arg);
      if (result == 'success') {
        context.read<CartCubit>().deleteAllOrganic();
      }
    } else {
      var arg = ScreenArguments<Map<String, dynamic>>({
        'garbageCollector': false,
        'garbageSize': widget.args[1].length,
      });
      final result = await Navigator.pushNamed(context, Routes.collectorMapScreen, arguments: arg);
      if (result == 'success') {
        context.read<CartCubit>().deleteAllReuse();
      }
    }
  }
}

class _CartView extends StatelessWidget {
  final List<String> images;
  final bool isOrganic;
  const _CartView({Key? key, required this.images, required this.isOrganic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    String type = isOrganic ? "Daur Ulang" : "Organik";
                    return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.delete, color: Colors.red,),
                              title: const Text('Hapus Gambar', style: TextStyle(color: Colors.red)),
                              onTap: () {
                                context.read<CartCubit>().deleteImage(isOrganic, images[index]);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.drive_file_move),
                              title: Text(type),
                              onTap: () {
                                if (isOrganic) {
                                  context.read<CartCubit>().organicToReusable(images[index]);
                                } else {
                                  context.read<CartCubit>().reusableToOrganic(images[index]);
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                    );
                  });
            },
            child: Image.file(
                File(images[index]),
              fit: BoxFit.cover,
            ),
          );
        },
    );
  }
}

