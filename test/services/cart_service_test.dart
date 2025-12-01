import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  late CartService cartService;
  late Product p1;
  late Product p2;

  setUp(() {
    cartService = CartService();
    p1 = Product(
      id: 'p1',
      name: 'Test Product 1',
      description: 'desc',
      price: 10.0,
      imageUrl: '',
      category: 'test',
      sizes: ['S'],
      colors: ['Black'],
    );
    p2 = Product(
      id: 'p2',
      name: 'Test Product 2',
      description: 'desc',
      price: 5.0,
      imageUrl: '',
      category: 'test',
      sizes: ['One Size'],
      colors: ['Red'],
    );
  });

  test('add item increases itemCount and total price', () {
    expect(cartService.itemCount, 0);
    cartService.addItem(p1, 2, 'S', 'Black');
    expect(cartService.itemCount, 2);
    expect(cartService.totalPrice, 20.0);
  });

  test('add same product with same options increases quantity', () {
    cartService.addItem(p1, 1, 'S', 'Black');
    cartService.addItem(p1, 3, 'S', 'Black');
    expect(cartService.itemCount, 4);
  });

  test('remove item deletes the item', () {
    cartService.addItem(p1, 1, 'S', 'Black');
    cartService.addItem(p2, 1, 'One Size', 'Red');
    expect(cartService.getItems().length, 2);
    cartService.removeItem(p1.id, 'S', 'Black');
    expect(cartService.getItems().length, 1);
  });

  test('update quantity sets the new quantity or removes if zero', () {
    cartService.addItem(p1, 2, 'S', 'Black');
    cartService.updateItemQuantity(p1.id, 'S', 'Black', 5);
    expect(cartService.itemCount, 5);
    cartService.updateItemQuantity(p1.id, 'S', 'Black', 0);
    expect(cartService.itemCount, 0);
  });

  test('clear cart empties everything', () {
    cartService.addItem(p1, 1, 'S', 'Black');
    cartService.clearCart();
    expect(cartService.itemCount, 0);
    expect(cartService.isEmpty, true);
  });
}
