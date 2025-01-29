import 'package:flash_card_app/main.dart';
import 'package:flash_card_app/models/flashcard_model.dart';
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

  Future<List<FlashCard>> retrieveEveryPublicFlashCard() async {
    final flashCardSets = await supabase.from('flash_card_set').select('id').eq('status', 'public');
    if (flashCardSets == null || flashCardSets.isEmpty) {
      print('No public flash card sets found');
      return [];
    }

    final setIds = flashCardSets.map((set) => set['id']).toList();
    final response = await supabase.from('flash_card').select().inFilter('set_id', setIds);
 print(response); 

    if (response == null || response.isEmpty) {
      print('No flashcards found for public sets');
      return [];
    }

    return response.map<FlashCard>((flashCard) => FlashCard.fromMap(flashCard)).toList();
  }

 
}


