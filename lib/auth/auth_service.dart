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




 Future<String?> getLoggedInUsername() async {
    final session = supabase.auth.currentSession;
    final userId = session?.user.id;

    if (userId == null) {
      print('No authenticated user found.');
      return null;
    }


    final response = await supabase.from('persons').select('username').eq('id', userId).single();

    if (response == null) {
      print('No matching person found for user ID: $userId');
      return null;
    }

    final username = response['username'];
    print('Username: $username');
    return username;
  }

}