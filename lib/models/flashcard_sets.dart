import 'package:flash_card_app/models/flashcard_model.dart';

class FlashCardSets {
  final int id;
  final String title;
  final String status;
  final int userId;
  // final List<FlashCard> flashcards;

  FlashCardSets({
    required this.id,
    required this.title,
    // required this.flashcards,
    required this.status,
    required this.userId,
  });

  factory FlashCardSets.fromMap(Map<String, dynamic> map) {
    return FlashCardSets(
      id: map['id'],
      title: map['title'],
      status: map['status'],
      userId: map['user_id'],
      // flashcards: (map['flashcards'] as List<dynamic>).map((item) => FlashCard.fromMap(item)).toList(),
    );
  }
}
