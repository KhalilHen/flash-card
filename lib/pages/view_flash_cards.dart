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
  bool isFlipping = false;

  final flipControl = FlipCardController();

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
      isFlipping = true;
      if (flipControl.state?.isFront == false) {
        flipControl.flipcard();
      }
      if (currentIndex < flashCards.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      showAnswer = false;
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          isFlipping = false;
        });
      });
    });
  }

  // void nextCard() {
  //   if (flipControl.state?.isFront == false) {
  //     flipControl.flipcard();
  //     Future.delayed(Duration(milliseconds: 200), () {
  //       setState(() {
  //         if (currentIndex < flashCards.length - 1) {
  //           currentIndex++;
  //         } else {
  //           currentIndex = 0;
  //         }
  //         showAnswer = false;
  //       });
  //     });
  //   } else {
  //     setState(() {
  //       if (currentIndex < flashCards.length - 1) {
  //         currentIndex++;
  //       } else {
  //         currentIndex = 0;
  //       }
  //       showAnswer = false;
  //     });
  //   }
  // }

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
            flashCards.isEmpty
                ?
                //  return Center(
                //     child: CircularProgressIndicator(),
                //   )
                Center(
                    child: Text("No flashcards found"),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlipCard(
                          controller: flipControl,
                          rotateSide: RotateSide.right,
                          frontWidget: Container(
                            margin: EdgeInsets.only(left: 25),
                            height: 300,
                            width: 300,

                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(38),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(24),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          flashCards[currentIndex].question,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            // child: FlipCard(),
                          ),
                          backWidget: Container(
                            margin: EdgeInsets.only(left: 25),
                            height: 300,
                            width: 300,

                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(38),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(24),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          !isFlipping ? flashCards[currentIndex].answer : '',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // isFlipping == true
                                        //     ? Text(
                                        //         flashCards[currentIndex].answer,
                                        //         style: GoogleFonts.poppins(
                                        //           fontSize: 18,
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.bold,
                                        //         ),
                                        //         textAlign: TextAlign.center,
                                        //       )
                                        //     : Text('Test'),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            // child: FlipCard(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showAnswer = !showAnswer;
                                  flipControl.flipcard();
                                });
                              },
                              child: Text(
                                "Show answer",
                                style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  // color: Color(0xFF6448FE)
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withAlpha(51),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.white.withAlpha(77))),
                                elevation: 0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // await Future.delayed(Duration(seconds: 3));
                                nextCard();
                              },
                              child: Text(
                                "Next ",
                                style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold,
                                  // color: Color(0xFF6448FE)
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white.withAlpha(51),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.white.withAlpha(77))),
                                elevation: 0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

            // : Expanded(
            //     child: Center(
            //       child:
            //           // stream: null,

            //           Container(

            //         width: 300,
            //         height: 300,
            //         child: Column(
            //           children: [
            //             Expanded(
            //               child: Card(
            //                 // decoration: BoxDecoration(),
            //                 elevation: 8,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(16),
            //                 ),
            //                 color: Colors.white.withAlpha(230),
            //                 //TODO Make it later animation
            //                 child: Container(
            //                   //Good height/width for Mobile L
            //                   width: 300,
            //                   height: 300,
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       SizedBox(
            //                         height: 20,
            //                       ),
            //                       //TODO Currently when answer is clicked on questioN. And you go next
            //                       //TODO It shows the answer of Q2. Add a reset bool later
            //                       Text(
            //                         // cards.question,
            //                         // "Question",
            //                         showAnswer ? flashCards[currentIndex].answer : flashCards[currentIndex].question,
            //                         style: GoogleFonts.poppins(
            //                           fontSize: 18,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Row(
            //               children: [
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     setState(() {
            //                       showAnswer = !showAnswer;
            //                     });
            //                   },
            //                   child: Text("Show answer"),
            //                 ),
            //                 SizedBox(
            //                   width: 20,
            //                 ),
            //                 ElevatedButton(
            //                   onPressed: () {
            //                     nextCard();
            //                   },
            //                   child: Text("Next question"),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // SizedBox(
            //   height: 20,
            // ),

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
