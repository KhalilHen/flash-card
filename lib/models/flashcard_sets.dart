import 'package:flash_card_app/models/flashcard_model.dart';

class FlashcardSets {

  final int id;
  final String title;
  final List<Flashcard> flashcards;


  FlashcardSets({
    required this.id,
    required this.title,
    required this.flashcards,
  });
}