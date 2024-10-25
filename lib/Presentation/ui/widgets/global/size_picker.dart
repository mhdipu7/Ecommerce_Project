import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({
    super.key,
    required this.sizes,
    required this.onChangedSize,
  });

  final List<String> sizes;
  final Function(String) onChangedSize;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        _buildSizeOptions(),
      ],
    );
  }

  Widget _buildSizeOptions() {
    return Wrap(
      spacing: 8,
      children: widget.sizes.map(
            (size) {
          return _buildSizeOption(size);
        },
      ).toList(),
    );
  }

  Widget _buildSizeOption(String size) {
    final bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () => _onSizeSelected(size),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.themeColor : Colors.white,
          border: Border.all(
            color: AppColors.themeColor,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          size,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: isSelected ? Colors.white : AppColors.themeColor,
          ),
        ),
      ),
    );
  }

  void _onSizeSelected(String selectedSize) {
    if (_selectedSize != selectedSize) {
      setState(() {
        _selectedSize = selectedSize;
        widget.onChangedSize(selectedSize);
      });
    }
  }
}
