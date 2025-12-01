import 'package:union_shop/models/collection.dart';
import 'package:union_shop/data/mock_data.dart';

class CollectionService {
  // Get all collections
  List<Collection> getAllCollections() {
    return MockData.collections;
  }

  // Get collection by ID
  Collection? getCollectionById(String id) {
    try {
      return MockData.collections
          .firstWhere((collection) => collection.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search collections by name
  List<Collection> searchCollections(String query) {
    final lowerQuery = query.toLowerCase();
    return MockData.collections
        .where((collection) =>
            collection.name.toLowerCase().contains(lowerQuery) ||
            collection.description.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
