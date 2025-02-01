import 'package:flash_card_app/auth/auth_provider.dart';
import 'package:flash_card_app/pages/login.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flash_card_app/pages/homepage.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onThemePressed;
  final VoidCallback? onThemePressed2;
  final VoidCallback? onThemePressed3;
  const CustomAppBar({
    super.key,
    required this.title,
    this.onThemePressed,
    this.onThemePressed2,
    this.onThemePressed3,
  });
//TODO When using smaller device if there is no space change it in a  drawer
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Row(
                children: [
                  if (onThemePressed == null) ...[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: const Icon(Icons.home),
                      color: Colors.white.withAlpha(77),
                      tooltip: "Go to homepage",
                      iconSize: 38,
                    ),
                  ] else ...[
                    IconButton(
                      onPressed: onThemePressed,
                      icon: const Icon(Icons.palette),
                      color: Colors.white.withAlpha(77),
                      tooltip: "Change theme",
                      iconSize: 38,
                    ),
                  ],
                  CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(77),
                    child: IconButton(
                      onPressed: () {
                        if (authProvider.isLoggedIn) {
                          authProvider.logOut();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        }
                      },
                      icon: Icon(authProvider.isLoggedIn ? Icons.logout : Icons.person),
                      tooltip: authProvider.isLoggedIn ? "Logout" : "View profile",
                      color: Colors.white.withAlpha(77),
                    ),
                  ),
                ],
              );
            },
          ),

          //  onThemePressed == null && onThemePressed3 != null ?

          // :

// }
//            else {

//            }
        ],
      ),
    );
  }
}
