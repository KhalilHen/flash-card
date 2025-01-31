import 'package:flash_card_app/pages/custom/custom_action_button.dart';
import 'package:flash_card_app/pages/display_flashcard_sets.dart';
import 'package:flash_card_app/pages/my_flashcard_sets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsContainer extends StatelessWidget {
//* Add title string here if using different titles
  final String title;
  final List<Map<String, dynamic>> actions;
  const ActionsContainer({
    Key? key,
    required this.title,
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
            title,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ActionButton(
                  title: action["title"],
                  icon: action["icon"],
                  onTap: action["onTap"],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );

    // return Container(
    //   padding: EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     color: Colors.white.withAlpha(38),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(left: 25),
    //         child: Text(
    //           title,
    //           style: GoogleFonts.poppins(
    //             fontSize: 20,
    //             color: Colors.white,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 30),
    //       Row(
    //         children: actions.map((action) {
    //           return Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //               child: ActionButton(
    //                 title: action["title"],
    //                 icon: action["icon"],
    //                 onTap: action["onTap"],
    //               ),
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ],
    //   ),
    // );
  }
}
