import 'package:flutter/material.dart';

class BuildItemSelector extends StatelessWidget {
  const BuildItemSelector({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? theme.primary : theme.onSecondary,
          border: Border.all(width: 1, color: theme.surface),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
