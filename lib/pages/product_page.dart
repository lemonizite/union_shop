import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/services/cart_service.dart';

class ProductPage extends StatefulWidget {
  // optional product id (when navigation passes argument)
  final String? productId;

  const ProductPage({super.key, this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService _productService = ProductService();

  Product? _product;
  bool _loading = true;

  int quantity = 1;
  String selectedSize = '';
  String selectedColor = '';

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    setState(() => _loading = true);

    // If an ID was provided, try to load it; otherwise use a first sample product
    if (widget.productId != null) {
      final p = _productService.getProductById(widget.productId!);
      if (p != null) {
        _initializeFromProduct(p);
      } else {
        setState(() {
          _product = null;
          _loading = false;
        });
      }
    } else {
      final all = _productService.getAllProducts();
      if (all.isNotEmpty) {
        _initializeFromProduct(all.first);
      } else {
        setState(() {
          _product = null;
          _loading = false;
        });
      }
    }
  }

  void _initializeFromProduct(Product p) {
    setState(() {
      _product = p;
      selectedSize = p.sizes.isNotEmpty ? p.sizes.first : '';
      selectedColor = p.colors.isNotEmpty ? p.colors.first : '';
      quantity = 1;
      _loading = false;
    });
  }

  void _addToCart() {
    if (_product == null) return;
    final cartService = Provider.of<CartService>(context, listen: false);
    cartService.addItem(_product!, quantity, selectedSize, selectedColor);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    // Loading or not found
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_product == null) {
      return Scaffold(
        body: Column(
          children: [
            Navbar(currentRoute: AppRoutes.product),
            const SizedBox(height: 60),
            const Center(
                child: Text('Product not found',
                    style: TextStyle(color: AppColors.greyDark))),
            const Footer(),
          ],
        ),
      );
    }

    final product = _product!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.product),
            Container(
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black)),
                        const SizedBox(height: 8),
                        Text('£${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.greyDark,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Text(product.description,
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.greyDark,
                                height: 1.6)),
                        const SizedBox(height: 32),
                        if (product.sizes.isNotEmpty) ...[
                          const Text('Size',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          DropdownButton<String>(
                            value: selectedSize.isEmpty
                                ? product.sizes.first
                                : selectedSize,
                            isExpanded: true,
                            items: product.sizes
                                .map((s) =>
                                    DropdownMenuItem(value: s, child: Text(s)))
                                .toList(),
                            onChanged: (v) => setState(
                                () => selectedSize = v ?? selectedSize),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (product.colors.isNotEmpty) ...[
                          const Text('Color',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          DropdownButton<String>(
                            value: selectedColor.isEmpty
                                ? product.colors.first
                                : selectedColor,
                            isExpanded: true,
                            items: product.colors
                                .map((c) =>
                                    DropdownMenuItem(value: c, child: Text(c)))
                                .toList(),
                            onChanged: (v) => setState(
                                () => selectedColor = v ?? selectedColor),
                          ),
                          const SizedBox(height: 16),
                        ],
                        const Text('Quantity',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => setState(() {
                                if (quantity > 1) quantity--;
                              }),
                            ),
                            SizedBox(
                                width: 50,
                                child: Center(
                                    child: Text(quantity.toString(),
                                        style: const TextStyle(fontSize: 16)))),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(() => quantity++)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: _addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('ADD TO CART',
                              style: TextStyle(letterSpacing: 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
