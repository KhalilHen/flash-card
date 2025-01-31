import 'package:flash_card_app/auth/auth_service.dart';
import 'package:flash_card_app/main.dart';
import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlashcardSetController {
  final authService = AuthService();

  Future<void> createFlashCardSet(BuildContext context, String title, String status, String description) async {
    final response = await supabase.from('flash_card_set').insert({
      'title': title,
      'status': status,
      'description': description,
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

  Future<List<FlashCardSets>> retrieverUserFlashCardSets(BuildContext context) async {
    final userResponse = await authService.getLoggedInUser();

    if (userResponse == null || userResponse.isEmpty) {
      // throw Exception('User not found');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not found')),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print(userResponse);

      final response = await supabase.from('flash_card_set').select().eq('userid', userResponse);

      if (response == null || response.isEmpty) {
        print('Failed to retrieve flashcard sets');
        return [];
      } else {
        return response.map<FlashCardSets>((flashCard) => FlashCardSets.fromMap(flashCard)).toList();
      }
    }
    return [];
  }

  // Future<
}
