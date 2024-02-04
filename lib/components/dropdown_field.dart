import 'package:flutter/material.dart';
import 'package:release_manager_ui/constant.dart';

class DropdownField extends StatefulWidget {
  final String title;
  final String buttonLabel;
  final List<String> data;
  final double width;
  final ValueChanged<String> onChanged;

  DropdownField({
    Key? key,
    required this.title,
    required this.buttonLabel,
    required this.data,
    required this.width,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 18, color: lightBlue),
          ),
        ),
        Container(
          height: 30,
          width: widget.width,
          child: InputDecorator(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              contentPadding: EdgeInsets.all(0),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  value: _value,
                  menuMaxHeight: 310,
                  onChanged: (value) {
                    setState(() {
                      _value = value.toString();
                      widget.onChanged(value.toString());
                    });
                  },
                  items: widget.data.map(buildMenuItem).toList(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
