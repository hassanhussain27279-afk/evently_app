import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.index,
    required this.currentIndex,
  });
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
    final isActive = index == currentIndex;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isActive ? 22 : 8,
      height: 8,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.secondary.withAlpha(100),
      ),
    );
  }
}
