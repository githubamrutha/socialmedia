import 'package:flutter/material.dart';

class CustomPostButton extends StatelessWidget {
  final void Function()? onTap;
  const CustomPostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 248, 211, 223),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        child: const Icon(Icons.done),
      ),
    );
  }
}
