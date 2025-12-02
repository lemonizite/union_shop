import 'package:union_shop/pages/collection_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/print_shack_page.dart';
import 'package:union_shop/pages/signup_page.dart';
import 'package:union_shop/pages/search_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
          ),
        ),
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => const HomePage(),
          AppRoutes.product: (context) => const ProductPage(),
          AppRoutes.collections: (context) => const CollectionsPage(),
          AppRoutes.about: (context) => const AboutPage(),
          AppRoutes.sale: (context) => const SalePage(),
          AppRoutes.cart: (context) => const CartPage(),
          AppRoutes.login: (context) => const LoginPage(),
          AppRoutes.printShack: (context) => const PrintShackPage(),
          '/signup': (context) => const SignupPage(),
          AppRoutes.search: (context) => const SearchPage(),
        },
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name ?? '');
          // handle /collection/:id
          if (uri.pathSegments.isNotEmpty &&
              uri.pathSegments[0] == 'collection') {
            final id = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
            if (id != null) {
              return MaterialPageRoute(
                builder: (_) => CollectionDetailPage(collectionId: id),
                settings: settings,
              );
            }
          }

          // handle /product with optional productId passed via arguments map
          if (settings.name == AppRoutes.product) {
            if (settings.arguments is Map) {
              final args = settings.arguments as Map;
              final String? pid = args['productId'] as String?;
              return MaterialPageRoute(
                  builder: (_) => ProductPage(productId: pid));
            }
            // fallback: show generic ProductPage (loads a default product)
            return MaterialPageRoute(builder: (_) => const ProductPage());
          }

          return null; // fall back to routes map
        },
      ),
    );
  }
}
