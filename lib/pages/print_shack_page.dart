import 'package:flutter/material.dart';
import 'package:union_shop/constants/app_constants.dart';
import 'package:union_shop/components/navbar.dart';
import 'package:union_shop/components/footer.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  // Core inputs
  String productName = '';
  String customMessage = '';

  // Selectors
  final List<String> _types = const ['T-Shirt', 'Hoodie', 'Mug'];
  final List<String> _sizes = const ['XS', 'S', 'M', 'L', 'XL'];
  final List<String> _colors = const ['Black', 'White', 'Navy', 'Red'];
  final List<String> _alignments = const ['Center', 'Left', 'Right'];
  final List<String> _styles = const ['Regular', 'Bold', 'Italic'];

  String selectedType = 'T-Shirt';
  String selectedSize = 'M';
  String selectedColor = 'Black';
  String selectedAlignment = 'Center';
  String selectedStyle = 'Regular';

  bool get _isApparel => selectedType == 'T-Shirt' || selectedType == 'Hoodie';

  TextAlign get _textAlign {
    switch (selectedAlignment) {
      case 'Left':
        return TextAlign.left;
      case 'Right':
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  TextStyle _buildPreviewTextStyle(double baseSize, {bool headline = false}) {
    FontWeight weight = FontWeight.normal;
    FontStyle fontStyle = FontStyle.normal;
    if (selectedStyle == 'Bold') weight = FontWeight.bold;
    if (selectedStyle == 'Italic') fontStyle = FontStyle.italic;

    final Color color = () {
      switch (selectedColor) {
        case 'White':
          return Colors.white;
        case 'Navy':
          return const Color(0xFF001F3F);
        case 'Red':
          return Colors.red.shade700;
        default:
          return Colors.black;
      }
    }();

    return TextStyle(
      fontSize: headline ? baseSize + 4 : baseSize,
      fontWeight: weight,
      fontStyle: fontStyle,
      color: color,
      height: 1.4,
    );
  }

  Color _mockProductBackground() {
    // Just a simple visual cue depending on selected type
    if (selectedType == 'Mug') return Colors.grey.shade200;
    // Apparel background to contrast with white text if needed
    return selectedColor == 'White' ? Colors.black : Colors.grey.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(currentRoute: AppRoutes.printShack),
            Container(
              padding: const EdgeInsets.all(40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth >= 900;
                  final form = _buildForm(context);
                  final preview = _buildPreview(context);

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: form),
                        const SizedBox(width: 40),
                        Expanded(child: preview),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      form,
                      const SizedBox(height: 24),
                      preview,
                    ],
                  );
                },
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'PRINT SHACK',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Customize Your Item',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Type
        _labeled(
            'Type',
            DropdownButton<String>(
              value: selectedType,
              isExpanded: true,
              items: _types
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  selectedType = v;
                  if (!_isApparel) {
                    // If switching to Mug, size no longer applies
                    selectedSize = 'M';
                  }
                });
              },
            )),

        // Size (only for apparel)
        if (_isApparel) ...[
          const SizedBox(height: 12),
          _labeled(
              'Size',
              DropdownButton<String>(
                value: selectedSize,
                isExpanded: true,
                items: _sizes
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => selectedSize = v ?? selectedSize),
              )),
        ],

        const SizedBox(height: 12),
        // Color
        _labeled(
            'Color',
            DropdownButton<String>(
              value: selectedColor,
              isExpanded: true,
              items: _colors
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) =>
                  setState(() => selectedColor = v ?? selectedColor),
            )),

        const SizedBox(height: 12),
        // Text alignment
        _labeled(
            'Text Alignment',
            DropdownButton<String>(
              value: selectedAlignment,
              isExpanded: true,
              items: _alignments
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
              onChanged: (v) =>
                  setState(() => selectedAlignment = v ?? selectedAlignment),
            )),

        const SizedBox(height: 12),
        // Text style
        _labeled(
            'Text Style',
            DropdownButton<String>(
              value: selectedStyle,
              isExpanded: true,
              items: _styles
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) =>
                  setState(() => selectedStyle = v ?? selectedStyle),
            )),

        const SizedBox(height: 16),
        // Product name
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Product Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onChanged: (value) => setState(() => productName = value),
        ),

        const SizedBox(height: 12),
        // Custom message
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Custom Message',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onChanged: (value) => setState(() => customMessage = value),
        ),

        const SizedBox(height: 24),
        // This button is optional for the coursework (demo preview is dynamic already)
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preview updated (demo).')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text('APPLY CHANGES'),
        ),
      ],
    );
  }

  Widget _buildPreview(BuildContext context) {
    final String name = productName.isEmpty ? 'Your Product Name' : productName;
    final String message = customMessage.isEmpty
        ? 'Your custom message will appear here...'
        : customMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _mockProductBackground(),
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: _textAlign == TextAlign.left
                ? CrossAxisAlignment.start
                : (_textAlign == TextAlign.right
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center),
            children: [
              // Mock product “area”
              Container(
                width: double.infinity,
                height: 220,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: _textAlign == TextAlign.left
                      ? CrossAxisAlignment.start
                      : (_textAlign == TextAlign.right
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.center),
                  children: [
                    Text(
                      name,
                      textAlign: _textAlign,
                      style: _buildPreviewTextStyle(18, headline: true),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: _textAlign,
                      style: _buildPreviewTextStyle(14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Selections summary
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _chip('Type: $selectedType'),
                  if (_isApparel) _chip('Size: $selectedSize'),
                  _chip('Color: $selectedColor'),
                  _chip('Align: $selectedAlignment'),
                  _chip('Style: $selectedStyle'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _labeled(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: AppColors.greyDark),
      ),
    );
  }
}
