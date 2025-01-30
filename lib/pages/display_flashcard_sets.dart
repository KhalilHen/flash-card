import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flutter/material.dart';

class DisplayFlashcardSets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flashCardSetController = FlashcardSetController();
    final flashCardController = FlashcardController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Sets'),
      ),
      body: Center(
        child: Text('No flashcard sets available.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // flashCardSetController.retrievePublicFlashCardSets();
          //  flashCardController. retrieveEveryPublicFlashCard() ;
          // retrieveAllFlashCardSets
          // flashCardController.retrieveEveryPublicFlashCard();
          flashCardSetController.retrieveAllFlashCardSets();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
