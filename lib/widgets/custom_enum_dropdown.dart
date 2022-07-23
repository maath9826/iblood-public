import 'package:flutter/material.dart';

class CustomEnumDropdown extends StatelessWidget {
  final String hint;
  final List<String> list;
  final String? selectedItem;
  final void Function(String?)? onChange;
  const CustomEnumDropdown({
    Key? key,
    required this.hint,
    required this.list,
    required this.selectedItem,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null) return 'This field is required';
      },
      menuMaxHeight: 200,
      isExpanded: true,
      hint: Text(hint),
      items: list
          .map(
            (el) => DropdownMenuItem(
              child: Text(el),
              value: el,
            ),
          )
          .toList(),
      value: selectedItem,
      onChanged: onChange,
    );
  }
}
