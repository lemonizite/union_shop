class Collection {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> productIds; // IDs of products in this collection

  Collection({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.productIds,
  });

  Collection copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? productIds,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      productIds: productIds ?? this.productIds,
    );
  }
}
