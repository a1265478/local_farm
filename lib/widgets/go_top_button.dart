import 'package:flutter/material.dart';

class GoTopButton extends StatelessWidget {
  const GoTopButton({Key? key, required this.scrollTop}) : super(key: key);
  final VoidCallback scrollTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        icon: const Icon(Icons.arrow_upward),
        onPressed: scrollTop,
      ),
    );
  }
}
