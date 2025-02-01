import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/create_flashcard.dart';
import 'package:flash_card_app/pages/create_flashcard_set.dart';
import 'package:flash_card_app/pages/custom/custom_action_container.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/display_flashcard_sets.dart';
import 'package:flash_card_app/pages/view_flash_cards.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyFlashCardSets extends StatelessWidget {
  const MyFlashCardSets({super.key});
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
              title: "Your flashcard sets",
              onThemePressed: null,
              onThemePressed2: () {},
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Your flashcard sets",
              style: GoogleFonts.poppins(fontSize: 28, color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            ActionsContainer(
              title: "Create  ",
              actions: [
                {
                  // "title": "Create Flashcard Set",
                  "title": " Flashcard Set",

                  "icon": Icons.library_add,
                  "onTap": () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateFlashcardSet()));
                  }
                },
                {
                  // "title": "Create flashcards",
                  "title": " flashcards",

                  "icon": Icons.create,
                  "onTap": () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateFlashCard()));
                  }
                }
              ],
            ),
            SizedBox(
              height: 50,
            ),
            // ActionsContainer(),
            Container(),
            Expanded(
                child: FutureBuilder<List<FlashCardSets>>(
                    future: flashCardSetController.retrieverUserFlashCardSets(context),
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

//Not working yet
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(38),
                                  borderRadius: BorderRadius.circular(20),
                                ),
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
                                    // flashCardSets[index].descruotuib ?? "Description",
                                    flashCardSets[index].description ?? "Description",
                                    style: GoogleFonts.poppins(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
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

//   Widget actionsContainer(BuildContext context) {
//     return Column(

//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Padding(padding: EdgeInsets.only(left: 25) , child: Text("Actions", style: GoogleFonts.poppins(fontSize:
//         20, color: Colors.white,  fontWeight: FontWeight.bold),),)
// ,
//         SizedBox(height: 30,),

//         Row(
//           children: [
//             Expanded(child:

//             )
//           ],
//         )
//       ],
//     );
//   }
}
