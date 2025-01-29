// import 'package:/flu';
import 'dart:async';
import 'dart:core';

import 'package:flash_card_app/main.dart';




class AuthService {



  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
  
 
// Future<AuthResponse> signInWithUsernameAndPassword(String username, String password) async {
//   final response = await Supabase.instance.client.auth.signInWith(
//     email: username,
//     password: password,
//   );
//   return response;
// }

  Future<String?> getLoggedInUser() async {
    final session = supabase.auth.currentSession;
    final User = session?.user.id;

    if (User == null) {
      print('No authenticated user found.');
      return null;
    }
    return User;
  }



}