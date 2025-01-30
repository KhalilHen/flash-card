import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/models/flashcard_model.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';

class CreateFlashCard extends StatefulWidget {
  const CreateFlashCard({Key? key}) : super(key: key);

  @override
  State<CreateFlashCard> createState() => _CreateFlashCardState();
}

class _CreateFlashCardState extends State<CreateFlashCard> {
  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final flashCardController = FlashcardController();

  //TODO Fix witha  notifier that it updates synchron everyw
  LinearGradient currentGradient = oceanBlueGradient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: currentGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Create flashcard",
                onThemePressed: null,
              ),
              SingleChildScrollView(
                child: Center(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: questionController,
                            decoration: InputDecoration(
                              labelText: 'Question',
                            ),
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
                            controller: answerController,
                            decoration: InputDecoration(
                              labelText: 'Answer',
                            ),
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
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  flashCardController.createFlashCard(context, questionController.text, answerController.text);
                                }
                              },
                              child: Text('Create Flashcard'))
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
