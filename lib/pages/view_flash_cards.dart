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
  int currentIndex = 0;
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

  void nextCard() {
    setState(() {
      if (currentIndex < flashCards.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // reset
      }
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

// !When i removed the future builder it gives a split sec errro with the unsude future builder it didn't (note)
            //TODO Make it visual better later
            Expanded(
              child: Center(
                child:
                    // stream: null,

                    Container(
                  width: 300,
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
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
                                //TODO Currently when answer is clicked on questioN. And you go next
                                //TODO It shows the answer of Q2. Add a reset bool later
                                Text(
                                  // cards.question,
                                  // "Question",
                                  showAnswer ? flashCards[currentIndex].answer : flashCards[currentIndex].question,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showAnswer = !showAnswer;
                              });
                            },
                            child: Text("Show answer"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              nextCard();
                            },
                            child: Text("Next question"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
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
    );
  }
}
