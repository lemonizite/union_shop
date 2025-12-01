class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final double originalPrice; // For sale items
  final bool isOnSale;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sizes,
    required this.colors,
    this.originalPrice = 0.0,
    this.isOnSale = false,
  });

  // Helper to calculate discount percentage
  int get discountPercentage {
    if (!isOnSale || originalPrice == 0) return 0;
    return (((originalPrice - price) / originalPrice) * 100).toInt();
  }

  // For creating a copy with modifications
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    List<String>? sizes,
    List<String>? colors,
    double? originalPrice,
    bool? isOnSale,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      originalPrice: originalPrice ?? this.originalPrice,
      isOnSale: isOnSale ?? this.isOnSale,
    );
  }
}
