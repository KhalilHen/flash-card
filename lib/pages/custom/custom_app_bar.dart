import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flash_card_app/pages/homepage.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onThemePressed;
  final VoidCallback? onThemePressed2;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onThemePressed,
    this.onThemePressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onThemePressed == null
              ? CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(77),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                    tooltip: "View profile",
                  ),
                )
              : Row(
                  children: [
                    IconButton(
                      onPressed: onThemePressed,
                      icon: const Icon(Icons.palette),
                      color: Colors.white.withAlpha(77),
                      tooltip: "Change theme",
                      iconSize: 38,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white.withAlpha(77),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        tooltip: "View profile",
                      ),
                    )
                  ],
                )

// }
//            else {

//            }
        ],
      ),
    );
  }
}
