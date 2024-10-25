import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    required this.onChangedColor,
  });

  final List<Color> colors;
  final Function(Color) onChangedColor;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.colors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildColorOptions()
      ],
    );
  }

  Widget _buildColorOptions() {
    return Wrap(
      spacing: 4,
      children: widget.colors.map(
        (color) {
          return _buildColorOption(color);
        },
      ).toList(),
    );
  }

  Widget _buildColorOption(Color item) {
    return GestureDetector(
      onTap: () => _onColorSelected(item),
      child: CircleAvatar(
        backgroundColor: item,
        radius: 16,
        child: _selectedColor == item
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  void _onColorSelected(Color selectedColor) {
    if (_selectedColor != selectedColor) {
      setState(() {
        _selectedColor = selectedColor;
        widget.onChangedColor(selectedColor);
      });
    }
  }
}
