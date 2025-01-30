import 'package:flash_card_app/auth/auth_service.dart';
import 'package:flutter/material.dart';


class  SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
 
 final emailController = TextEditingController();
 final passwordController = TextEditingController();
 final usernameController = TextEditingController();
 final authService = AuthService();

 
 final isUsernametaken = false;
 final isEmailTaken = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(



    );
  }
}