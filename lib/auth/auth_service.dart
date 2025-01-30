// import 'package:/flu';
import 'dart:async';
import 'dart:core';

import 'package:flash_card_app/main.dart';
import 'package:flash_card_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  //Not yet tested reused from previous project
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> checkUser(String email, String password, GlobalKey<FormState> formKey, authProvider, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await authProvider.login(email, password);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<String?> getLoggedInUser() async {
    final session = supabase.auth.currentSession;
    final User = session?.user.id;

    if (User == null) {
      print('No authenticated user found.');
      return null;
    }
    return User;
  }
  //Not yet tested reused from previous project

  Future<String?> getLoggedInUsername() async {
    final session = supabase.auth.currentSession;
    final userId = session?.user.id;

    if (userId == null) {
      print('No authenticated user found.');
      return null;
    }

    final response = await supabase.from('person').select('username').eq('id', userId).single();

    if (response == null) {
      print('No matching person found for user ID: $userId');
      return null;
    }

    final username = response['username'];
    print('Username: $username');
    return username;
  }



 Future<bool> isEmailAvailable(String email) async {
    try {
      final response = await supabase.from('person').select().match({'email': email}).maybeSingle();

      return response == null;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
    return emailRegex.hasMatch(email);
  } 


    Future<bool> isUsernameAvailable(String username) async {
    try {
    
      final response = await Supabase.instance.client.from('person').select().match({'username': username}).maybeSingle();

      return response == null;
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  
  }
}
