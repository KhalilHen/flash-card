import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flutter/material.dart';

class DisplayFlashcardSets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flashCardSetController = FlashcardSetController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Sets'),
      ),
      body: Center(
        child: Text('No flashcard sets available.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          flashCardSetController.retrievePublicFlashCardSets();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}