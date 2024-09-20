import 'package:flutter/material.dart';
import 'package:googlemaps/components/glass_morphism.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassmorphicContainer(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          borderRadius: 0,
          blur: 10,
          border: 0,
          linearGradient: LinearGradient(colors: [
            Color.fromARGB(255, 140, 169, 198),
            const Color.fromARGB(255, 248, 211, 223)
          ]),
          borderGradient: const LinearGradient(colors: [
            Colors.white38,
            Colors.white54,
          ]),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const Icon(Icons.person), Text(text) //username
              ],
            ),
          ),
        ),
      ),
    );
  }
}
