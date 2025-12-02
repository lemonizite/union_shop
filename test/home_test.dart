import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartService()),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      // Wait for network images to fail gracefully
      await tester.pump();

      // Check for hero section text
      expect(find.text('Placeholder Hero Title'), findsOneWidget);
      expect(find.text('This is placeholder text for the hero section.'),
          findsOneWidget);

      // Check for products section header
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // Check for product cards
      expect(find.text('Placeholder Product 1'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);

      // Check for browse button
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
    });
  });
}
