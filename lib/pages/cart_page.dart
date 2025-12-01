import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(currentRoute: AppRoutes.cart),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Consumer<CartService>(
                builder: (context, cartService, _) {
                  final items = cartService.getItems();
                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 72, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          const Text('Your cart is empty',
                              style: TextStyle(color: AppColors.greyDark)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.collections),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor),
                            child: const Text('Shop now'),
                          )
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shopping Cart',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, i) {
                            final CartItem item = items[i];
                            return ListTile(
                              leading: Image.network(item.product.imageUrl,
                                  width: 56, height: 56, fit: BoxFit.cover),
                              title: Text(item.product.name),
                              subtitle: Text(
                                  'Size: ${item.selectedSize} • Color: ${item.selectedColor}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () =>
                                        cartService.updateItemQuantity(
                                            item.product.id,
                                            item.selectedSize,
                                            item.selectedColor,
                                            item.quantity - 1),
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cartService.updateItemQuantity(
                                            item.product.id,
                                            item.selectedSize,
                                            item.selectedColor,
                                            item.quantity + 1),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () => cartService.removeItem(
                                        item.product.id,
                                        item.selectedSize,
                                        item.selectedColor),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // Summary
                      const SizedBox(height: 12),
                      Text(
                          'Subtotal: £${cartService.cart.subtotal.toStringAsFixed(2)}'),
                      Text(
                          'Tax (10%): £${cartService.cart.tax.toStringAsFixed(2)}'),
                      Text(
                          'Shipping: £${cartService.cart.shipping.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      Text(
                          'Total: £${cartService.cart.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // For now, perform a simple "checkout" action clearing the cart
                          cartService.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Checkout complete (demo)')));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: const Size.fromHeight(48)),
                        child: const Text('Checkout'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
