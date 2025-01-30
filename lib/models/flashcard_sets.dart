import 'package:flash_card_app/models/flashcard_model.dart';

class FlashCardSets {
  final int id;
  final String title;
  final String description;
  final String status;
  final String userId;
  // final List<FlashCard> flashcards;

  FlashCardSets({
    required this.id,
    required this.title,
    // required this.flashcards,
    required this.status,
    required this.userId,
    required this.description,
  });

//TODO Add parsing methods
  factory FlashCardSets.fromMap(Map<String, dynamic> map) {
    return FlashCardSets(
      id: map['id'],
      title: map['title'],
      status: map['status'],
      userId: map['user_id']?.toString() ?? '',
      description: map['description'],

      // flashcards: (map['flashcards'] as List<dynamic>).map((item) => FlashCard.fromMap(item)).toList(),
    );
  }
}
