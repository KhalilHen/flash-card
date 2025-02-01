import 'dart:async';

import 'package:flash_card_app/auth/auth_provider.dart';
import 'package:flash_card_app/auth/auth_service.dart';
import 'package:flash_card_app/pages/create_flashcard.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/login.dart';
import 'package:flash_card_app/pages/sign-up.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

//TODO Finish further the userna,e
class _SignUpPageState extends State<SignUpPage> {
  final authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  bool isPasswordVisible = false;

  bool isConfirmPasswordVisible = false;

  //
  bool? isNameAvaible;
  bool? isEmailAvailable;
  String usernameError = '';
  Timer? usernameDebounce;
  Timer? emailDebounce;
  @override
  void initState() {
    super.initState();
    emailListener(emailController, checkEmailAvailability);
    usernameListener(usernameController, checkUsernameAvailability);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    usernameController.dispose();
    usernameDebounce?.cancel();
    emailDebounce?.cancel();
    super.dispose();
  }

  void usernameListener(TextEditingController usernameController, Function(String) checkUsernameAvailability) {
    usernameController.addListener(() {
      if (usernameDebounce?.isActive ?? false) usernameDebounce?.cancel();
      usernameDebounce = Timer(const Duration(milliseconds: 500), () {
        final username = usernameController.text;
        if (username.length > 3 && authService.isValidUsername(username)) {
          checkUsernameAvailability(usernameController.text);
        } else {
          setState(() {
            isNameAvaible = false;
          });
        }
      });
    });
  }

  emailListener(TextEditingController emailController, Function(String) checkEmailAvailability) {
    emailController.addListener(() {
      if (emailDebounce?.isActive ?? false) emailDebounce?.cancel();
      emailDebounce = Timer(const Duration(milliseconds: 2000), () {
        final email = emailController.text;
        if (authService.isValidEmail(email)) {
          checkEmailAvailability(email);
        } else {
          setState(() {});
        }
        checkEmailAvailability(emailController.text);
      });
    });
  }

  Future<void> checkEmailAvailability(String email) async {
    try {
      final available = await authService.isEmailAvailable(email);
      setState(() {
        isEmailAvailable = available;
      });
    } catch (e) {
      setState(() {
        isEmailAvailable = false;
      });
      print(e);
    }
  }

  Future<void> checkUsernameAvailability(String username) async {
    try {
      final available = await authService.isUsernameAvailable(username);
      setState(() {
        isNameAvaible = available;
      });
    } catch (e) {
      setState(() {
        isNameAvaible = false;
        usernameError = 'An error occurred while checking the username';
      });
      print(e);
    }
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
                title: "Sign-up",
                onThemePressed: null,
                onThemePressed2: null,
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
                                "Welcome Sign up!",
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
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    labelText: 'username',
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                    filled: true,
                                    fillColor: Colors.white.withAlpha(51),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: isNameAvaible == null
                                        ? null
                                        : isNameAvaible!
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
                                              )
                                            : const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
                                              ),
                                    //*not the styling i like biti too mcuh
                                    // errorStyle: GoogleFonts.poppins(
                                    //     fontSize: 14,

                                    //     // fontWeight:
                                    //     //  FontWeight.bold,

                                    //     shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 0.5))

                                    //     ]),
                                    contentPadding: EdgeInsets.all(16),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
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
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                    ),
                                    labelText: 'email',
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
                                    hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
                                    filled: true,
                                    fillColor: Colors.white.withAlpha(51),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: isEmailAvailable == null
                                        ? null
                                        : isEmailAvailable!
                                            ? Icon(Icons.check, color: Colors.green, shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))])
                                            // ? Icons.check,
                                            // color: Colors.green,
                                            // shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
                                            : const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                shadows: [
                                                  Shadow(
                                                      blurRadius: 2,
                                                      //for
                                                      color: Colors.black,
                                                      offset: Offset(1, 1)
                                                      // format
                                                      )
                                                ],
                                              ),
                                    contentPadding: EdgeInsets.all(16),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
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
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  obscureText: !isConfirmPasswordVisible,
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    labelText: 'Confirm password',
                                    labelStyle: GoogleFonts.poppins(color: Colors.white),
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
                                      return 'Please enter your password here ';
                                    }
                                    if (value != passwordController.text) {
                                      return 'Passwords are not the same';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final response = await authService.signUpWithEmaiPassword(
                                      emailController.text,
                                      passwordController.text,
                                      usernameController.text,
                                    );
                                    if (response != null && response.user != null) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Sign up failed. Please try again.')),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white.withAlpha(51),
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: Colors.white.withAlpha(77))),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "Sign up!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold,

                                    color: Colors.white,
                                    //  color: Color(0xFF6448FE)
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account, ",
                                    style: GoogleFonts.poppins(color: Colors.white.withAlpha(204)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                      },
                                      child: Text(
                                        "Login in!",
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
