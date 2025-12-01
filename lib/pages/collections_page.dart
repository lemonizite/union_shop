import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/collection_service.dart';
import 'package:union_shop/services/product_service.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final CollectionService _collectionService = CollectionService();
  final ProductService _productService = ProductService();

  List<Collection> _allCollections = [];
  List<Collection> _filteredCollections = [];

  String _searchQuery = '';
  String _sort = 'name_asc'; // or 'name_desc', 'price_asc', 'price_desc'
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  void _loadCollections() {
    _allCollections = _collectionService.getAllCollections();
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchQuery.toLowerCase();
    var results = _allCollections.where((c) {
      final nameMatch = c.name.toLowerCase().contains(query);
      final descMatch = c.description.toLowerCase().contains(query);
      return nameMatch || descMatch;
    }).toList();

    // If selectedCategory filter applied, filter collections containing that category id
    if (_selectedCategory != 'all') {
      results = results.where((c) => c.id == _selectedCategory).toList();
    }

    // Optionally sort collections by the cheapest product in them (price_asc/desc)
    if (_sort == 'price_asc' || _sort == 'price_desc') {
      results.sort((a, b) {
        final aProducts = a.productIds
            .map((id) => _productService.getProductById(id))
            .whereType<Product>()
            .toList();
        final bProducts = b.productIds
            .map((id) => _productService.getProductById(id))
            .whereType<Product>()
            .toList();

        final aPrice = aProducts.isEmpty
            ? double.infinity
            : aProducts.map((p) => p.price).reduce((v, e) => v < e ? v : e);
        final bPrice = bProducts.isEmpty
            ? double.infinity
            : bProducts.map((p) => p.price).reduce((v, e) => v < e ? v : e);

        return _sort == 'price_asc'
            ? aPrice.compareTo(bPrice)
            : bPrice.compareTo(aPrice);
      });
    } else {
      // Sort by name
      results.sort((a, b) => _sort == 'name_asc'
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name));
    }

    setState(() {
      _filteredCollections = results;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
    _applyFilters();
  }

  void _onSortChanged(String newSort) {
    setState(() {
      _sort = newSort;
    });
    _applyFilters();
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    // Build the available categories for a quick filter (including 'all')
    final categories = [
      'all',
      ..._allCollections.map((c) => c.id).toSet().toList()
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.collections),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row + search & filter widgets
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'COLLECTIONS',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Browse by collection or filter to find what you need.',
                              style: TextStyle(color: AppColors.greyDark),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 260,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search collections',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _sort,
                        items: const [
                          DropdownMenuItem(
                              value: 'name_asc', child: Text('Name ↑')),
                          DropdownMenuItem(
                              value: 'name_desc', child: Text('Name ↓')),
                          DropdownMenuItem(
                              value: 'price_asc', child: Text('Cheapest')),
                          DropdownMenuItem(
                              value: 'price_desc',
                              child: Text('Most expensive')),
                        ],
                        onChanged: (v) => _onSortChanged(v!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Category chips
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = cat == _selectedCategory;
                        return ChoiceChip(
                          label: Text(cat == 'all' ? 'All' : cat),
                          selected: isSelected,
                          onSelected: (_) => _onCategoryChanged(cat),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Results grid
                  _filteredCollections.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 48),
                          child: Center(
                            child: Text(
                              'No collections were found.',
                              style: TextStyle(color: AppColors.greyDark),
                            ),
                          ),
                        )
                      : GridView.builder(
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
                            childAspectRatio: 1.2,
                          ),
                          itemCount: _filteredCollections.length,
                          itemBuilder: (context, index) {
                            final c = _filteredCollections[index];
                            return _CollectionCard(
                              collection: c,
                              onTap: () {
                                // Navigate to a collection detail page (create that next step).
                                Navigator.pushNamed(
                                    context, '/collection/${c.id}');
                              },
                              productService: _productService,
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

class _CollectionCard extends StatelessWidget {
  final Collection collection;
  final VoidCallback onTap;
  final ProductService productService;

  const _CollectionCard({
    required this.collection,
    required this.onTap,
    required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    // Grab up to 3 product images to show a collage-like preview
    final sampleProducts = collection.productIds
        .map((id) => productService.getProductById(id))
        .whereType<Product>()
        .take(3)
        .toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: sampleProducts.map((p) {
                  final idx = sampleProducts.indexOf(p);
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: idx == 0 ? 0 : 2,
                          right: idx == sampleProducts.length - 1 ? 0 : 2),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(p.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    collection.description,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.greyDark),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
