import 'package:flash_card_app/auth/auth_provider.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateFlashcardSet extends StatefulWidget {
  CreateFlashcardSet({Key? key}) : super(key: key);

  @override
  State<CreateFlashcardSet> createState() => _CreateFlashcardSetState();
}

class _CreateFlashcardSetState extends State<CreateFlashcardSet> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final flashcardSetController = FlashcardSetController();

  bool isPublic = false;

  void isPublicSet(bool value) {
    isPublic = value;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: themeProvider.currentGradient),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Create Flashcard Set",
                onThemePressed: null,
                onThemePressed2: null,
                onThemePressed3: () {},
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                "Create a Flashcard Set",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  labelText: 'Title',
                                  hintText: "History",
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
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  // prefixIcon: const Icon(Icons.email_outlined),
                                  labelText: 'Description',
                                  hintText: "This is a set about history",
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
                              SizedBox(
                                height: 10,
                              ),
                              //* This can improve later
                              Row(
                                children: [
                                  Checkbox(
                                    value: isPublic,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isPublic = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Make this set public',
                                    style: GoogleFonts.poppins(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              ElevatedButton(
                                onPressed: () {

     if (formKey.currentState!.validate()) {
                      String status = isPublic ? "public" : "private";
                      flashcardSetController.createFlashCardSet(context, titleController.text, status , descriptionController.text );
                    }
                
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6448FE)),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
