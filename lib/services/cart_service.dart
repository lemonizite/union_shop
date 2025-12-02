import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/services/product_service.dart';

class CartService extends ChangeNotifier {
  final ProductService _productService = ProductService();
  Cart _cart = Cart(items: []);

  static const String _storageKey = 'cart_state_v1';

  CartService() {
    _restoreCart();
  }

  Cart get cart => _cart;
  int get itemCount => _cart.itemCount;
  double get totalPrice => _cart.totalPrice;
  double get grandTotal => _cart.grandTotal;
  bool get isEmpty => _cart.isEmpty;

  void addItem(Product product, int quantity, String size, String color) {
    final cartItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: size,
      selectedColor: color,
    );
    _cart = _cart.addItem(cartItem);
    notifyListeners();
    _persistCart();
  }

  void removeItem(String productId, String size, String color) {
    _cart = _cart.removeItem(productId, size, color);
    notifyListeners();
    _persistCart();
  }

  void updateItemQuantity(
      String productId, String size, String color, int newQuantity) {
    _cart = _cart.updateItemQuantity(productId, size, color, newQuantity);
    notifyListeners();
    _persistCart();
  }

  void clearCart() {
    _cart = _cart.clear();
    notifyListeners();
    _persistCart();
  }

  List<CartItem> getItems() => _cart.items;

  Future<void> _persistCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final payload = _cart.items
          .map((i) => {
                'productId': i.product.id,
                'quantity': i.quantity,
                'size': i.selectedSize,
                'color': i.selectedColor,
              })
          .toList();
      await prefs.setString(_storageKey, jsonEncode(payload));
    } catch (_) {
      // Ignore persistence errors (e.g., tests without plugin)
    }
  }

  Future<void> _restoreCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString == null || jsonString.isEmpty) return;

      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      final List<CartItem> restored = [];

      for (final item in decoded) {
        final map = item as Map<String, dynamic>;
        final String? pid = map['productId'] as String?;
        final int qty = (map['quantity'] as num?)?.toInt() ?? 1;
        final String size = (map['size'] as String?) ?? '';
        final String color = (map['color'] as String?) ?? '';
        if (pid == null) continue;

        final Product? product = _productService.getProductById(pid);
        if (product == null) continue;

        restored.add(CartItem(
          product: product,
          quantity: qty,
          selectedSize: size,
          selectedColor: color,
        ));
      }

      _cart = Cart(items: restored);
      notifyListeners();
    } catch (_) {
      // Ignore restore errors (e.g., MissingPluginException in tests)
    }
  }
}
