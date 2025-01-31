import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewFlashCard extends StatefulWidget {
  final FlashCardSets flashcardSet;

  const ViewFlashCard({
    super.key,
    required this.flashcardSet,
  });

  @override
  State<ViewFlashCard> createState() => _ViewFlashCardState();
}

class _ViewFlashCardState extends State<ViewFlashCard> {
  LinearGradient currentGradient = oceanBlueGradient;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "Flash card",
              onThemePressed: null,
              onThemePressed2: () {},
            ),

            //TODO Make it visual better later
            Expanded(
              child: Center(
                  child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white.withAlpha(230),
                //TODO Make it later animation
                child: Container(
                  //Good height/width for Mobile L
                  width: 300,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "How many stripes does a zebra have?" ?? "There is no question",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 20,
            ),

            // Row(
            //   children: [
            //     ElevatedButton(onPressed: () {}, child: Text("Show answer")),
            //     SizedBox(
            //       width: 20,
            //     ),
            //     ElevatedButton(onPressed: () {}, child: Text("Next question")),
            //   ],
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print("content:" + widget.flashcardSet.title);
      // }),
    );
  }
}
