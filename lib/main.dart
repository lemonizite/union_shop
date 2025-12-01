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
        },
      ),
    );
  }
}
