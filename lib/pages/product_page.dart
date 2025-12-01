import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  String selectedSize = 'Medium';
  String selectedColor = 'Black';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.product),
            Container(
              padding: const EdgeInsets.all(40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '£35.00',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.greyDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'This is a great product with high quality materials.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyDark,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Size Selector
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: selectedSize,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'Small',
                              child: Text('Small'),
                            ),
                            DropdownMenuItem(
                              value: 'Medium',
                              child: Text('Medium'),
                            ),
                            DropdownMenuItem(
                              value: 'Large',
                              child: Text('Large'),
                            ),
                            DropdownMenuItem(
                              value: 'XL',
                              child: Text('XL'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        // Color Selector
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: selectedColor,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'Black',
                              child: Text('Black'),
                            ),
                            DropdownMenuItem(
                              value: 'White',
                              child: Text('White'),
                            ),
                            DropdownMenuItem(
                              value: 'Blue',
                              child: Text('Blue'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedColor = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        // Quantity
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 50,
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Add to Cart Button
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to cart!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'ADD TO CART',
                            style: TextStyle(letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
