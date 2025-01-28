class Flashcard {
  final int id; 
  final int setId;

  final String question;
  final String answer;

 

   Flashcard({
    required this.id,
    required this.setId,
    required this.question,
    required this.answer,
  });
}

class FlashcardSet {
  final String title;
  List<Flashcard> flashcards;

  FlashcardSet({required this.title, required this.flashcards});
}
