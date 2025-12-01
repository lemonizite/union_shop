import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.about),
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Who We Are',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Union Shop is dedicated to providing high-quality products and exceptional customer service. '
                    'We believe in creating a community where students can find everything they need in one place.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyDark,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'To provide affordable, quality merchandise that celebrates student culture and community pride. '
                    'We are committed to sustainability and ethical sourcing in all our products.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyDark,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Our Team',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Our team is composed of passionate individuals dedicated to delivering the best shopping experience. '
                    'We work hard to bring you the latest trends and timeless classics.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyDark,
                      height: 1.6,
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
