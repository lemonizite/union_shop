import 'package:union_shop/models/product.dart';
import 'package:union_shop/data/mock_data.dart';

class ProductService {
  // Get all products
  List<Product> getAllProducts() {
    return MockData.products;
  }

  // Get product by ID
  Product? getProductById(String id) {
    try {
      return MockData.products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get products by category
  List<Product> getProductsByCategory(String category) {
    return MockData.products
        .where((product) => product.category == category)
        .toList();
  }

  // Get all sale products
  List<Product> getSaleProducts() {
    return MockData.products.where((product) => product.isOnSale).toList();
  }

  // Search products by name
  List<Product> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return MockData.products
        .where((product) =>
            product.name.toLowerCase().contains(lowerQuery) ||
            product.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // Sort products
  List<Product> sortProducts(List<Product> products, String sortBy) {
    final sorted = List<Product>.from(products);
    switch (sortBy) {
      case 'price_asc':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_desc':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'name_asc':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      default:
        break;
    }
    return sorted;
  }

  // Filter products by price range
  List<Product> filterByPriceRange(
    List<Product> products,
    double minPrice,
    double maxPrice,
  ) {
    return products
        .where(
            (product) => product.price >= minPrice && product.price <= maxPrice)
        .toList();
  }
}
