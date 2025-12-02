import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4d2963);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF666666);
}

class AppRoutes {
  static const String home = '/';
  static const String product = '/product';
  static const String collections = '/collections';
  static const String collectionDetail = '/collection/:id';
  static const String about = '/about';
  static const String sale = '/sale';
  static const String cart = '/cart';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String printShack = '/print-shack';
  static const String search = '/search';
}

class AppStrings {
  static const String appName = 'Union Shop';
  static const String placeholderHeaderText = 'PLACEHOLDER HEADER TEXT';
  static const String browseProducts = 'BROWSE PRODUCTS';
  static const String productsSection = 'PRODUCTS SECTION';
  static const String placeholderFooter = 'Placeholder Footer';
}
