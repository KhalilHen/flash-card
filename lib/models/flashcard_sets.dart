import 'package:flash_card_app/models/flashcard_model.dart';

class FlashCardSets {

  final int id;
  final String title;
  final List<Flashcard> flashcards;


  FlashCardSets({
    required this.id,
    required this.title,
    required this.flashcards,
  });
}