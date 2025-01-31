import 'package:flash_card_app/pages/custom/custom_action_button.dart';
import 'package:flash_card_app/pages/display_flashcard_sets.dart';
import 'package:flash_card_app/pages/my_flashcard_sets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsContainer extends StatelessWidget {
//* Add title string here if using different titles
  final List<Map<String, dynamic>> actions;
  const ActionsContainer({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "Actions",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: actions.map((action) {
            return Expanded(
              child: ActionButton(
                title: action["title"],
                icon: action["icon"],
                onPressed: action["onTap"],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
