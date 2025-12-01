import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/collection.dart';

class MockData {
  // Mock Products
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Classic Hoodie',
      description: 'Comfortable and stylish hoodie perfect for any occasion.',
      price: 35.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'hoodies',
      sizes: ['Small', 'Medium', 'Large', 'XL', 'XXL'],
      colors: ['Black', 'White', 'Navy Blue', 'Grey'],
      isOnSale: false,
    ),
    Product(
      id: '2',
      name: 'University T-Shirt',
      description: 'High-quality cotton t-shirt with university branding.',
      price: 15.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'apparel',
      sizes: ['Small', 'Medium', 'Large', 'XL'],
      colors: ['White', 'Black', 'Blue'],
      isOnSale: false,
    ),
    Product(
      id: '3',
      name: 'Campus Cap',
      description: 'Classic baseball cap with embroidered logo.',
      price: 18.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'accessories',
      sizes: ['One Size'],
      colors: ['Black', 'White'],
      isOnSale: true,
      originalPrice: 25.00,
    ),
    Product(
      id: '4',
      name: 'Water Bottle',
      description:
          'Insulated water bottle to keep your drinks at the right temperature.',
      price: 22.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'merchandise',
      sizes: ['One Size'],
      colors: ['Blue', 'Black', 'Red'],
      isOnSale: false,
    ),
    Product(
      id: '5',
      name: 'Joggers',
      description: 'Comfortable joggers for casual wear.',
      price: 28.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'apparel',
      sizes: ['Small', 'Medium', 'Large', 'XL'],
      colors: ['Black', 'Grey', 'Navy'],
      isOnSale: true,
      originalPrice: 45.00,
    ),
    Product(
      id: '6',
      name: 'Backpack',
      description: 'Durable backpack perfect for students.',
      price: 50.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'merchandise',
      sizes: ['One Size'],
      colors: ['Black', 'Blue'],
      isOnSale: false,
    ),
    Product(
      id: '7',
      name: 'Polo Shirt',
      description: 'Premium polo shirt with university crest.',
      price: 32.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'apparel',
      sizes: ['Small', 'Medium', 'Large', 'XL'],
      colors: ['White', 'Navy', 'Black'],
      isOnSale: false,
    ),
    Product(
      id: '8',
      name: 'Winter Coat',
      description: 'Warm winter coat for cold weather.',
      price: 80.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      category: 'hoodies',
      sizes: ['Small', 'Medium', 'Large', 'XL'],
      colors: ['Black', 'Navy', 'Grey'],
      isOnSale: true,
      originalPrice: 120.00,
    ),
  ];

  // Mock Collections
  static final List<Collection> collections = [
    Collection(
      id: 'hoodies',
      name: 'Hoodies',
      description: 'Cozy hoodies for all occasions',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      productIds: ['1', '8'],
    ),
    Collection(
      id: 'apparel',
      name: 'Apparel',
      description: 'Comfortable clothing essentials',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      productIds: ['2', '5', '7'],
    ),
    Collection(
      id: 'merchandise',
      name: 'Merchandise',
      description: 'Cool branded merchandise',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      productIds: ['4', '6'],
    ),
    Collection(
      id: 'accessories',
      name: 'Accessories',
      description: 'Complete your look with accessories',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
      productIds: ['3'],
    ),
  ];
}
