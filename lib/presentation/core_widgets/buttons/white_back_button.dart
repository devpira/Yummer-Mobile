import 'package:flutter/material.dart';

class WhiteBackButton extends StatelessWidget {
  final double? shadow;
  const WhiteBackButton({
    this.shadow,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: shadow != null? Colors.black.withOpacity(shadow!):  Colors.black.withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
