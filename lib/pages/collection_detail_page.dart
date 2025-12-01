import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';
import 'package:union_shop/components/product_card.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/collection_service.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/services/cart_service.dart';

class CollectionDetailPage extends StatefulWidget {
  final String collectionId;

  const CollectionDetailPage({super.key, required this.collectionId});

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  final _collectionService = CollectionService();
  final _productService = ProductService();

  Collection? collection;
  List<Product> products = [];
  List<Product> filteredProducts = [];

  String sort = 'name_asc';
  String query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    collection = _collectionService.getCollectionById(widget.collectionId);
    if (collection != null) {
      products = collection!.productIds
          .map((id) => _productService.getProductById(id))
          .whereType<Product>()
          .toList();
    } else {
      products = [];
    }
    _applyFilters();
  }

  void _applyFilters() {
    var list = List<Product>.from(products);
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      list = list
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q))
          .toList();
    }

    switch (sort) {
      case 'price_asc':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'name_desc':
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      default:
        list.sort((a, b) => a.name.compareTo(b.name));
    }

    setState(() {
      filteredProducts = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (collection == null) {
      return Scaffold(
        body: Column(
          children: [
            Navbar(currentRoute: AppRoutes.collections),
            const SizedBox(height: 80),
            const Center(
                child: Text('Collection not found',
                    style: TextStyle(color: AppColors.greyDark))),
            const Footer(),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.collections),
            Container(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(collection!.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(collection!.description,
                      style: const TextStyle(color: AppColors.greyDark)),
                  const SizedBox(height: 20),

                  // Filters / search / sort row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Search in this collection',
                              border: OutlineInputBorder()),
                          onChanged: (v) {
                            query = v;
                            _applyFilters();
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: sort,
                        items: const [
                          DropdownMenuItem(
                              value: 'name_asc', child: Text('Name')),
                          DropdownMenuItem(
                              value: 'name_desc', child: Text('Name ↓')),
                          DropdownMenuItem(
                              value: 'price_asc', child: Text('Price ↑')),
                          DropdownMenuItem(
                              value: 'price_desc', child: Text('Price ↓')),
                        ],
                        onChanged: (v) {
                          sort = v ?? 'name_asc';
                          _applyFilters();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Product grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 900
                          ? 3
                          : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder: (_, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          // navigate to product page with argument
                          Navigator.pushNamed(context, AppRoutes.product,
                              arguments: {'productId': product.id});
                        },
                      );
                    },
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
