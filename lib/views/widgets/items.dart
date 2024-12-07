import 'package:cube_business/views/pages/home/widgets/item.dart';
import 'package:flutter/material.dart';
// Import your reusable Items widget

import 'package:flutter/material.dart';
// Import your reusable Items widget

class ItemsRow extends StatelessWidget {
  final List<Widget> items; // Accept a list of Items widgets
  final double spacing; // Add optional spacing between items

  const ItemsRow({
    super.key,
    required this.items,
    this.spacing = 16.0, // Default spacing between items
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread items evenly
      children: items
          .map(
            (item) => Expanded(
              flex: 1, // Ensure items take equal width
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                child: item, // Dynamically add items to the row
              ),
            ),
          )
          .toList(),
    );
  }
}
