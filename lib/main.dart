import 'package:flash_card_app/pages/create_flashcard.dart';
import 'package:flash_card_app/pages/create_flashcard_set.dart';
import 'package:flash_card_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  
  
      WidgetsFlutterBinding.ensureInitialized();
  //* Here topsecret supabase intialization

  runApp(MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' flashcard',
      theme: ThemeData(
 
        useMaterial3: true,
      ),
      // home:  CreateFlashCard(),
      home: HomePage(),
    );
  }
}


