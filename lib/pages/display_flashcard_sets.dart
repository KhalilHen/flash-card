import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/view_flash_cards.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DisplayFlashcardSets extends StatefulWidget {
  @override
  State<DisplayFlashcardSets> createState() => _DisplayFlashcardSetsState();
}

class _DisplayFlashcardSetsState extends State<DisplayFlashcardSets> {
  @override
  Widget build(BuildContext context) {
    final flashCardSetController = FlashcardSetController();
    final flashCardController = FlashcardController();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentGradient,
        ),
        child: Column(
          children: [
            CustomAppBar(
              title: "Public Flashcard sets",
              onThemePressed: null,
              onThemePressed2: () {},
            ),
            //TODO Improve this later
            // !! The future builder doesn't work yet.
            Expanded(
                child: FutureBuilder<List<FlashCardSets>>(
                    future: flashCardSetController.retrievePublicFlashCardSets(),
                    builder: (context, snapshot) {
                      print("Data   ${snapshot.data}");

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        print("Error ${snapshot.error}");

                        //Better error handling for the users of the system.
                        return Center(
                          child: Text("Sorry, something went wrong"),
                        );
                      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text("No Flashcard sets found"),
                        );
                      } else {
                        List flashCardSets = snapshot.data!;

                        return ListView.builder(
                          itemCount: flashCardSets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewFlashCard(
                                      flashcardSet: flashCardSets[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(38),
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                // **Note In future  change text color some white some dark. Baewd on some theme
                                child: ListTile(
                                  leading: Icon(
                                    Icons.book,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    flashCardSets[index].title ?? "Title",
                                    style: GoogleFonts.poppins(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    flashCardSets[index].description ?? "Description",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),

      //TODO Improve this visually
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.grey,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: 0,
      //   onTap: (index) {
      //     // if (index == 0) {
      //     //   Navigator.pushReplacement(
      //     //     context,
      //     //     MaterialPageRoute(builder: (context) => const HomePage()),
      //     //   );
      //     // }

      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Public flashcards'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'my flashcards')
      //   ],
      // ),
    );
  }
}
