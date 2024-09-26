import 'package:cube_business/core/color_constant.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/home/widgets/no_product.dart';
import 'package:cube_business/views/pages/products/product_detils_screen.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/model/product_model.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  Stream<List<Product>>? _productsStream;
  String? _errorMessage;

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
              'تعذر الحصول على بيانات المتجر. يرجى التحقق من تسجيل الدخول.';
        });
      } else {
        setState(() {
          _productsStream =
              ProductService(storeId: currentUser.storeId!).getAllProducts();
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء جلب بيانات المنتجات: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المنتجات'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(context, AddProductScreen());
        },
        child: Icon(Icons.add),
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
                      return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: NoProduct());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return ProductWidget(product: product);
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

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: product.imageUrl.isNotEmpty
            ? Image.network(
                product.imageUrl.first,
                width: 50,
                filterQuality: FilterQuality.medium,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported, size: 50),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('${product.price.toStringAsFixed(2)} ر.ع'),
        onTap: () {
          navigateTo(
            context,
            ProductDetailsScreen(product: product),
          );
        },
      ),
    );
  }
}
