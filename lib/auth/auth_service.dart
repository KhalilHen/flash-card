// import 'package:/flu';
import 'package:flash_card_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';




class AuthService {


 
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