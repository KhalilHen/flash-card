import 'package:flash_card_app/auth/auth_provider.dart';
import 'package:flash_card_app/auth/auth_service.dart';
import 'package:flash_card_app/pages/create_flashcard.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/sign-up.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: themeProvider.currentGradient),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Login",
                onThemePressed: null,
                onThemePressed2: null,
                onThemePressed3: () {},
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                "Welcome login!",
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                    ),
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
                                    hintText: "test@hotmail.com",
                                    hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                    filled: true,
                                    fillColor: Colors.white.withAlpha(51),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (!value.contains('@') || !value.contains('.')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  obscureText: !isPasswordVisible,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                    filled: true,
                                    fillColor: Colors.white.withAlpha(51),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  authService.checkUser(emailController.text, passwordController.text, formKey, authProvider, context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white.withAlpha(51),
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.white.withAlpha(77))),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,

                                      // color: Color(0xFF6448FE)
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don''t have an account",
                                    style: GoogleFonts.poppins(color: Colors.white.withAlpha(204)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                                      },
                                      child: Text(
                                        "Sign up!",
                                        style: GoogleFonts.poppins(
                                            // fontWeight: FontWeight.bold,
                                            //  color: null
                                            color: Colors.white.withAlpha(204)),
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
