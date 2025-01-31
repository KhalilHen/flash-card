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
        // Added comment so it doesn't automaticly format this code in 1 line.
        question: map['question'],
        answer: map['answer']);
  }
}
