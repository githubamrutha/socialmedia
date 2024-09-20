import 'package:flutter/material.dart';

import '../font_manager.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //     onTap: onTap,
        //  child:
        Container(
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 140, 169, 198),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: FontManager().getTextStyle(context,
              color: Theme.of(context).colorScheme.secondary,
              lWeight: FontWeight.w600,
              fontSize: 26),
        ),
      ),
    );
    //  Container(
    //   height: 55,
    //   decoration: BoxDecoration(
    //       color: Theme.of(context).colorScheme.primary,
    //       borderRadius: BorderRadius.circular(20)),
    //   margin: EdgeInsets.all(20),
    //   padding: EdgeInsets.all(10),
    //   child: Center(
    //     child: Text(
    //       text,
    //       style: FontManager().getTextStyle(context,
    //           color: Theme.of(context).colorScheme.secondary,
    //           lWeight: FontWeight.w600,
    //           fontSize: 26),
    //     ),
    //   ),
    // ),
    // );
  }
}
