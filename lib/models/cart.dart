import 'package:union_shop/models/cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  // Get total number of items in cart
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  // Get total price of all items
  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Get subtotal (before tax/shipping)
  double get subtotal => totalPrice;

  // Estimate tax (10%)
  double get tax => subtotal * 0.1;

  // Estimate shipping (£5 if not empty, otherwise £0)
  double get shipping => items.isEmpty ? 0 : 5.0;

  // Grand total
  double get grandTotal => subtotal + tax + shipping;

  // Add or update item in cart
  Cart addItem(CartItem cartItem) {
    final existingIndex = items.indexWhere(
      (item) =>
          item.product.id == cartItem.product.id &&
          item.selectedSize == cartItem.selectedSize &&
          item.selectedColor == cartItem.selectedColor,
    );

    if (existingIndex >= 0) {
      // Item exists, increase quantity
      final updatedItems = List<CartItem>.from(items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + cartItem.quantity,
      );
      return Cart(items: updatedItems);
    } else {
      // New item
      return Cart(items: [...items, cartItem]);
    }
  }

  // Remove item from cart
  Cart removeItem(String productId, String size, String color) {
    final updatedItems = items
        .where((item) => !(item.product.id == productId &&
            item.selectedSize == size &&
            item.selectedColor == color))
        .toList();
    return Cart(items: updatedItems);
  }

  // Update quantity of an item
  Cart updateItemQuantity(
    String productId,
    String size,
    String color,
    int newQuantity,
  ) {
    if (newQuantity <= 0) {
      return removeItem(productId, size, color);
    }

    final updatedItems = items.map((item) {
      if (item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    return Cart(items: updatedItems);
  }

  // Clear entire cart
  Cart clear() => Cart(items: []);

  // Check if cart is empty
  bool get isEmpty => items.isEmpty;
}
