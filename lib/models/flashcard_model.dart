class FlashCard {
  final int id;
  final int setId;

  final String question;
  final String answer;

  FlashCard({
    required this.id,
    required this.setId,
    required this.question,
    required this.answer,
  });

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      id: map['id'],
      setId: map['set_id'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}

class FlashcardSet {
  final String title;
  List<FlashCard> flashcards;

  FlashcardSet({required this.title, required this.flashcards});
}
