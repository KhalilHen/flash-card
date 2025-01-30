import 'package:flash_card_app/main.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlashcardSetController {
  Future<void> createFlashCardSet(BuildContext context, String title, String status) async {
    final response = await supabase.from('flash_card_set').insert({
      'title': title,
      'status': status,
    }).select();

    if (response == null || response.isEmpty) {
      print(response);
      print('Failed to create flashcard set');
      return;
    }

    print('Flashcard set created successfully');
    // Notify the user about the successful creation of the flashcard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Flashcard set created successfully: ${response[0]['title']}'),
      ),
    );
  }

  Future<List<FlashCardSets>> retrievePublicFlashCardSets() async {
    final response = await supabase.from('flash_card_set').select().eq('status', 'public');

    if (response == null || response.isEmpty) {
      print('Failed to retrieve flashcard sets');
      return [];
    }
    print(response);
    return response.map<FlashCardSets>((flashCard) => FlashCardSets.fromMap(flashCard)).toList();
  }

  Future<List<FlashCardSets>> retrieveAllFlashCardSets() async {
    final response = await supabase.from('flash_card_set').select();
    if (response == null || response.isEmpty) {
      print('Failed to retrieve flashcard sets');
      return [];
    }
    print(response);

    return response.map<FlashCardSets>((flashCard) => FlashCardSets.fromMap(flashCard)).toList();
  }

  // Future<
}
