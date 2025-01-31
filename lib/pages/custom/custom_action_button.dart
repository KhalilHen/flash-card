import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  // final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    // required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            // color: Colors.white,
            color: Colors.grey[100], //giving bit of grey tint
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, offset: Offset(0, 4))]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: Color(0xFF6448FE),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Actions",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6448FE),
              ),
            )
          ],
        ),
      ),
    );
  }
}
