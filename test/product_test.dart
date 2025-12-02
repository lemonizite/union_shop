import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  group('Product Page Tests', () {
    testWidgets('should display product page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartService()),
          ],
          child: const MaterialApp(
            home: ProductPage(),
          ),
        ),
      );

      // Wait for async loading to complete
      await tester.pumpAndSettle();

      // Page should have rendered
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display product page with basic elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartService()),
          ],
          child: const MaterialApp(
            home: ProductPage(),
          ),
        ),
      );

      // Wait for product to load (defaults to first product from mock data)
      await tester.pumpAndSettle();

      // Check for Size dropdown label
      expect(find.text('Size'), findsOneWidget);

      // Check for Color dropdown label
      expect(find.text('Color'), findsOneWidget);

      // Check for Quantity label
      expect(find.text('Quantity'), findsOneWidget);

      // Check for add to cart button
      expect(find.text('ADD TO CART'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Check for quantity controls (+ and - buttons)
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });
  });
}
