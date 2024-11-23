import 'package:cube_business/views/pages/home/widgets/item.dart';
import 'package:flutter/material.dart';
// Import your reusable Items widget

class ItemsRow extends StatelessWidget {
  final List<Items> items; // Accept a list of Items widgets

  const ItemsRow({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Row(
            children: items
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: item, // Dynamically add items to the row
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
