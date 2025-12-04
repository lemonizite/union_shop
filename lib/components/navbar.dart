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
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          // Top banner with sale message
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: AppColors.primaryColor,
            child: const Text(
              "BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Main header with logo and navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                // Logo - 50% larger
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.home),
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: 28,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        width: 28,
                        height: 28,
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 32),
                // Navigation links
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _navLink(context, 'Home', AppRoutes.home),
                        const SizedBox(width: 24),
                        _navLink(context, 'Shop', AppRoutes.collections),
                        const SizedBox(width: 24),
                        _navLink(context, 'Print Shack', AppRoutes.printShack),
                        const SizedBox(width: 24),
                        _navLink(context, 'SALE!', AppRoutes.sale),
                        const SizedBox(width: 24),
                        _navLink(context, 'About', AppRoutes.about),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            // External link - does not have to function per brief
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('External UPSU.net link')),
                            );
                          },
                          child: const Text(
                            'UPSU.net',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyDark,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                // Icons: search, account, cart
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _navigateTo(context, AppRoutes.search),
                  tooltip: 'Search',
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () => _navigateTo(context, AppRoutes.login),
                  tooltip: 'Account',
                ),
                Consumer<CartService>(
                  builder: (context, cartService, child) {
                    final itemCount = cartService.itemCount;
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined),
                          onPressed: () => _navigateTo(context, AppRoutes.cart),
                          tooltip: 'Cart',
                        ),
                        if (itemCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                  minWidth: 18, minHeight: 18),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _showMenuDrawer(context),
                  tooltip: 'Menu',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navLink(BuildContext context, String label, String route) {
    final bool isActive = currentRoute == route;
    return GestureDetector(
      onTap: () => _navigateTo(context, route),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? AppColors.primaryColor : AppColors.greyDark,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
        ),
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
              title: const Text('Shop'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.collections);
              },
            ),
            ListTile(
              title: const Text('Print Shack'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.printShack);
              },
            ),
            ListTile(
              title: const Text('SALE!'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.sale);
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(context, AppRoutes.about);
              },
            ),
          ],
        ),
      ),
    );
  }
}
