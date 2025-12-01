import 'package:flutter/material.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

class CartService extends ChangeNotifier {
  Cart _cart = Cart(items: []);

  Cart get cart => _cart;

  int get itemCount => _cart.itemCount;

  double get totalPrice => _cart.totalPrice;

  double get grandTotal => _cart.grandTotal;

  bool get isEmpty => _cart.isEmpty;

  // Add item to cart
  void addItem(Product product, int quantity, String size, String color) {
    final cartItem = CartItem(
      product: product,
      quantity: quantity,
      selectedSize: size,
      selectedColor: color,
    );
    _cart = _cart.addItem(cartItem);
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String productId, String size, String color) {
    _cart = _cart.removeItem(productId, size, color);
    notifyListeners();
  }

  // Update item quantity
  void updateItemQuantity(
    String productId,
    String size,
    String color,
    int newQuantity,
  ) {
    _cart = _cart.updateItemQuantity(productId, size, color, newQuantity);
    notifyListeners();
  }

  // Clear entire cart
  void clearCart() {
    _cart = _cart.clear();
    notifyListeners();
  }

  // Get cart items
  List<CartItem> getItems() => _cart.items;
}
