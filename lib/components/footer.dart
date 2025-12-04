import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 900;

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildOpeningHours()),
                const SizedBox(width: 60),
                Expanded(child: _buildHelpInfo()),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOpeningHours(),
              const SizedBox(height: 40),
              _buildHelpInfo(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Opening Hours',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '❄️ Winter Break Closure Dates ❄️',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Closing 4pm 19/12/2025\nReopening 10am 05/01/2026\nLast post date: 12pm on 18/12/2025',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyDark,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        const Text(
          '(Term Time)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark,
          ),
        ),
        const Text(
          'Monday - Friday 10am - 4pm',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '(Outside of Term Time / Consolidation Weeks)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark,
          ),
        ),
        const Text(
          'Monday - Friday 10am - 3pm',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Purchase online 24/7',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help and Information',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 12),
        _footerLink('Search'),
        const SizedBox(height: 8),
        _footerLink('Terms & Conditions of Sale Policy'),
        const SizedBox(height: 24),
        const Text(
          '© 2025 Union Shop. All rights reserved.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _footerLink(String text) {
    return GestureDetector(
      onTap: () {
        // Links are placeholder for now
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.greyDark,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
