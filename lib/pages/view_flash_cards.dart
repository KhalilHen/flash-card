import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/models/flashcard_model.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//To make the card flip
import 'package:flutter_flip_card/flutter_flip_card.dart';

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
  final flashCardController = FlashcardController();
  List<FlashCard> flashCards = [];
  bool showAnswer = false;
  LinearGradient currentGradient = oceanBlueGradient;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    final cards = await flashCardController.retrieveFlashCardFromSet(widget.flashcardSet.id);

    print(cards);
    if (cards == null || cards.isEmpty) {
      print("No cards found");
      return;
    }
    setState(() {
      flashCards = cards;
    });
  }

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
                  child: FutureBuilder<List<FlashCard>>(
                      // stream: null,

                      future: flashCardController.retrieveFlashCardFromSet(widget.flashcardSet.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          print(snapshot.data);

                          // print(widget.flashcardSet.id);
                          return Center(
                            child: Text("Sorry, something went wrong"),
                          );
                        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text("No Flashcard found"),
                          );
                        } else {
                          final cards = snapshot.data!;
                          return Card(
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
                                    // cards.question,
                                    // "Question",
                                    flashCards[0].question,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  //too test if it works
                                  Text(flashCards[0].answer)
                                ],
                              ),
                            ),
                          );
                        }
                      })),
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        // print("content:" + widget.flashcardSet.title);

        flashCardController.retrieveFlashCardFromSet(widget.flashcardSet.id);
      }),
    );
  }
}
