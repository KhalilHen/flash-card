import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/view_flash_cards.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
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
                            //TODO Improve it visual later
                            return GestureDetector(
                              onTap: () {
                                // To use a flashcard set. Maybe better to use hero not sure yet
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewFlashCard(flashcardSet: flashCardSets[index],),
                                  ),
                                );


//Not working yet
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.book),
                                  title: Text(flashCardSets[index].title ?? "Title"),
                                  subtitle: Text(
                                    // flashCardSets[index].descruotuib ?? "Description",
                                    flashCardSets[index].description ?? "Description",

                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // flashCardSetController.retrievePublicFlashCardSets();
          //  flashCardController. retrieveEveryPublicFlashCard() ;
          // retrieveAllFlashCardSets
          // flashCardController.retrieveEveryPublicFlashCard();
          // flashCardSetController.retrieveAllFlashCardSets();
          flashCardSetController.retrievePublicFlashCardSets();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
