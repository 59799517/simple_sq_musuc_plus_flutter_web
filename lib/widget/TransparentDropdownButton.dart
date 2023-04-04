import 'package:flutter/material.dart';

class TransparentDropdownButton extends StatefulWidget {
  final List<String> items;
  final double width;

  TransparentDropdownButton({required this.items, required this.width});

  @override
  _TransparentDropdownButtonState createState() =>
      _TransparentDropdownButtonState();
}

class _TransparentDropdownButtonState extends State<TransparentDropdownButton> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      width: widget.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          style: const TextStyle(color: Colors.white),
          dropdownColor: Colors.grey[800],
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
