import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/services/cart_service.dart';

class Navbar extends StatelessWidget {
  final String currentRoute;

  const Navbar({
    super.key,
    required this.currentRoute,
  });

  void _navigateTo(BuildContext context, String route) {
    if (currentRoute != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: AppColors.primaryColor,
            child: const Text(
              AppStrings.placeholderHeaderText,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
          // Main header
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => _navigateTo(context, AppRoutes.home),
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  // Navigation items
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // the same IconButtons as before — but for the cart IconButton below, use Consumer.
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.home);
              },
            ),
            ListTile(
              title: const Text('Collections'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.collections);
              },
            ),
            ListTile(
              title: const Text('Sale'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.sale);
              },
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.about);
              },
            ),
            ListTile(
              title: const Text('Print Shack'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.printShack);
              },
            ),
          ],
        ),
      ),
    );
  }
}
