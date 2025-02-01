import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/models/flashcard_model.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateFlashCard extends StatefulWidget {
  const CreateFlashCard({Key? key}) : super(key: key);

  @override
  State<CreateFlashCard> createState() => _CreateFlashCardState();
}

class _CreateFlashCardState extends State<CreateFlashCard> {
  final flashCardSetController = FlashcardSetController();
  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final flashCardController = FlashcardController();
  List<String> flashCardSetTitles = [];

  @override
  void initState() {
    super.initState();
    fetchFlashCardSetTitles();
  }

  Future<void> fetchFlashCardSetTitles() async {
    final sets = await flashCardSetController.retrieveAllFlashCardSets();
    setState(() {
      flashCardSetTitles = sets.map((set) => set.title).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // App bar
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Create flashcard",
                onThemePressed: null,
              ),
              //App bar ends here
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create a Flashcard",
                            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              // maxLines: 3,
                              // maxLines: 2,
                              controller: questionController,
                              decoration: InputDecoration(
                                labelText: 'Question',
                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                hintText: "How many stripes has a zebra",
                                hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.quiz,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white.withAlpha(51),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              maxLines: 3,
                              controller: answerController,
                              decoration: InputDecoration(
                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                labelText: 'Anwser',
                                hintText: "Too much",
                                prefixIcon: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                filled: true,
                                fillColor: Colors.white.withAlpha(51),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),

                          // !! Future answer description

                          SizedBox(
                            height: 20,
                          ),
                          // //TODO Improve later the pop-up inside the dropdown
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.white.withAlpha(230),
                              decoration: InputDecoration(
                                labelText: 'Flashcard set',
                                labelStyle: GoogleFonts.poppins(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white.withAlpha(128)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.white.withAlpha(25),
                              ),
                              style: GoogleFonts.poppins(color: Colors.white),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: flashCardSetTitles.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ),

                          // ! In future another formfield option to adda  false answer
                          SizedBox(
                            height: 32,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                flashCardController.createFlashCard(context, questionController.text, answerController.text);
                              }
                            },
                            child: Text('Create Flashcard',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,

                                    // color: Color(0xFF6448FE)
                                    color: Colors.white)
                                // color: Colors.white),
                                ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.white.withAlpha(51),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.white.withAlpha(77))),
                              elevation: 0,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
