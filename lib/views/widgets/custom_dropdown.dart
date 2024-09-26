import 'package:cube_business/core/catogery_type.dart';
import 'package:flutter/material.dart';


class CustomDropdown extends StatefulWidget {
  final String label;
  final String hintText;
  final List<CategoryType> items;
  final CategoryType? selectedItem;
  final ValueChanged<CategoryType?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  CategoryType? _selectedItem;

  // Map for translating enum to Arabic labels
  final Map<CategoryType, String> categoryLabels = {
    CategoryType.Elegance: 'أناقة',
    CategoryType.Food: 'طعام',
    CategoryType.Clothes: 'ملابس',
  };

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            _showCustomDropdown(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey, width: 2.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedItem != null
                      ? categoryLabels[_selectedItem]! // Display Arabic label
                      : widget.hintText,
                  style: TextStyle(
                    color: _selectedItem == null ? Colors.grey : Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCustomDropdown(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final double dropdownOffset = 50.0; // Adjust this value to move the dropdown further down

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, dropdownOffset), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset(0, dropdownOffset)), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final CategoryType? newValue = await showMenu<CategoryType>(
      context: context,
      position: position,
      items: widget.items.map((CategoryType item) {
        return PopupMenuItem<CategoryType>(
          value: item,
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
            ),
            width: MediaQuery.of(context).size.width - 32, // Full width minus padding
            child: Text(categoryLabels[item]!), // Display Arabic label
          ),
        );
      }).toList(),
      elevation: 8.0,
    );

    if (newValue != null) {
      setState(() {
        _selectedItem = newValue;
      });
      widget.onChanged(newValue);
    }
  }
}
