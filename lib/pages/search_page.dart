import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';
import 'package:union_shop/components/product_card.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/product_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();

  List<Product> _searchResults = [];
  bool _hasSearched = false;

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _searchResults = _productService.searchProducts(query);
      _hasSearched = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.search),
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SEARCH',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onChanged: _performSearch,
                    onSubmitted: _performSearch,
                  ),
                  const SizedBox(height: 32),
                  if (!_hasSearched)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Text(
                          'Start typing to search for products',
                          style: TextStyle(color: AppColors.greyDark),
                        ),
                      ),
                    )
                  else if (_searchResults.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Text(
                          'No products found',
                          style: TextStyle(color: AppColors.greyDark),
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_searchResults.length} ${_searchResults.length == 1 ? 'result' : 'results'} found',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.greyDark,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 900
                                    ? 3
                                    : (MediaQuery.of(context).size.width > 600
                                        ? 2
                                        : 1),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final product = _searchResults[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.product,
                                  arguments: {'productId': product.id},
                                );
                              },
                            );
                          },
                        ),
                      ],
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
