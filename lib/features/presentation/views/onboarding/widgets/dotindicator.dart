import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {


  final bool isActive;

  const DotIndicator({
    super.key, this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isActive ? 8 : 4,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? const Color.fromARGB(255, 157, 46, 220) : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(50))
      ), duration: const Duration(milliseconds: 300),
    );
  }
}