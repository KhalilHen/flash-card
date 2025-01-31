import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/create_flashcard_set.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
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
              height: 70,
            ),
            Text(
              "Your flashcard sets",
              style: GoogleFonts.poppins(fontSize: 28, color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Text("Actions"),
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
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.book),
                                  title: Text(
                                    flashCardSets[index].title ?? "Title",
                                    style: GoogleFonts.poppins(),
                                  ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateFlashcardSet()));
        },
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.add,
          color: Color(0xFF6448FE),
        ),
        label: Text(
          "Create Set",
          style: TextStyle(
            color: Color(0xFF6448FE),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
