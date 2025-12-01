import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/cart_page.dart';

void main() {
  testWidgets('CartPage shows items when cart not empty',
      (WidgetTester tester) async {
    final cartService = CartService();
    final p = Product(
      id: 'test',
      name: 'Widget product',
      description: 'd',
      price: 12.0,
      imageUrl: '',
      category: 'test',
      sizes: ['S'],
      colors: ['Black'],
    );
    cartService.addItem(p, 2, 'S', 'Black');

    // Set a larger test window so the page has enough height and avoids RenderFlex overflow
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(800, 1200);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(
      ChangeNotifierProvider<CartService>.value(
        value: cartService,
        child: MaterialApp(home: CartPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Shopping Cart'), findsOneWidget);
    expect(find.text('Widget product'), findsOneWidget);
    expect(find.text('2'), findsWidgets); // quantity shown
  });
}
