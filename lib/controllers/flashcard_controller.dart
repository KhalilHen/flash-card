import 'package:flash_card_app/main.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlashcardController {

  Future<void> createFlashCard(BuildContext context, String question, String answer) async {
    final response = await supabase.from('flash_card').insert({
      'title': 'Test',
      'question': question,
      'answer': answer,
      // 'set_id': 1,
    }).select();

    if (response == null || response.isEmpty) {
      print(response);
      print('Failed to create flashcard');
      return;
    }

    print('Flashcard created successfully');
    // Notify the user about the successful creation of the flashcard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Flashcard created successfully: ${response[0]['question']} - ${response[0]['answer']}'),
      ),
    );
  }

  // Future<List<FlashcardSets>> retrieveFlashCardsSett() {


  // }


}