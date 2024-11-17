import 'package:cube_business/core/color_constant.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/provider/home_provider.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/home/widgets/no_product.dart';
import 'package:cube_business/views/pages/products/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/model/product_model.dart';
import 'package:provider/provider.dart';
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  Stream<List<Product>>? _productsStream;
  String? _errorMessage;
  String? _storeId;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      UserModel? currentUser = await AuthService().getCurrentUserData();
      if (currentUser == null || currentUser.storeId == null) {
        setState(() {
          _errorMessage =
              'ERROR.';
        });
      } else {
        setState(() {
          _storeId = currentUser.storeId;
          _productsStream = ProductService(storeId: _storeId!).getAllProducts();
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'NO PRODUCT FOUND: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider= Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, const AddProductScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _productsStream == null
              ? const Center(child: CircularProgressIndicator())
              : StreamBuilder<List<Product>>(
                  stream: _productsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('ERROR: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: NoProduct());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return ProductWidget(
                            product: product,
                            storeId: _storeId!,
                          );
                        },
                      );
                    }
                  },
                ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;
  final String storeId;

  const ProductWidget({
    super.key,
    required this.product,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
        final homeProvider= Provider.of<HomeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: ListTile(
          leading: product.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.imageUrl.first,
                    width: 50,
                    filterQuality: FilterQuality.medium,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.image_not_supported, size: 50),
          title: Text(product.name),
          subtitle: Text(product.description),
          trailing: IconButton(
            onPressed: () async {
              bool confirmDelete = await _confirmDeleteDialog(context);
              if (confirmDelete) {
                await ProductService(storeId: storeId)
                    .deleteProduct(product.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('DELETED!'),
                  ),
                );
              }

              homeProvider.fetchProductCount();
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
          onTap: () {
            navigateTo(
              context,
              ProductDetailsScreen(product: product),
            );
          },
        ),
      ),
    );
  }

Future<bool> _confirmDeleteDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  ) ?? false;
}}