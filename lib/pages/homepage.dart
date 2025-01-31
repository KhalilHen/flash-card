import 'package:flash_card_app/auth/auth_service.dart';
import 'package:flash_card_app/pages/create_flashcard.dart';
import 'package:flash_card_app/pages/create_flashcard_set.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/pages/display_flashcard_sets.dart';
import 'package:flash_card_app/pages/login.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  LinearGradient currentGradient = oceanBlueGradient;

//* Auth
  final authService = AuthService();
  String? username;
  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final fetchedUsername = await authService.getLoggedInUsername();
    setState(() {
      username = fetchedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentGradient,
        ),
        //Safeare to prevent different mobile device having different screen
        child: SafeArea(
            child: Column(
          children: [
            // customAppBar(),
            CustomAppBar(
              title: "Flashcard App",
              onThemePressed: () {
                customColorPickerDialog();
              },
              onThemePressed2: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            // SizedBox(height: 24,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    welcomeContainer(),
                    SizedBox(
                      height: 24,
                    ),
                    actionsContainer(context),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Custom app bar
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => FlashcardViewer()),
          //   // MaterialPageRoute(builder: (context) => CreateFlashcardSet()),
          // );
          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Widget customAppBar() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text("Flashcard App", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),

  //         // TODO Add here a iconbutton to change the   theme style.
  //         // IconButton(onPressed: () {}, icon: Icon(Icons.circle_)),
  //         Row(
  //           children: [
  //             IconButton(
  //               onPressed: () {
  //                 customColorPickerDialog();
  //               },
  //               icon: Icon(Icons.palette),
  //               color: Colors.white.withAlpha(77),
  //               tooltip: "Change theme",
  //               // iconSize: 22,
  //               iconSize: 38,
  //             ),
  //             CircleAvatar(
  //               backgroundColor: Colors.white.withAlpha(77),
  //               child: IconButton(
  //                 onPressed: () {},
  //                 icon: Icon(Icons.person),
  //                 tooltip: "View profile",
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget welcomeContainer() {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(38),
          borderRadius: BorderRadius.circular(20),
        ),
        child: username != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back $username!",
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "Ready to continue learning?",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white.withAlpha(204)),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  //TODO Improve the text
                  Text(
                    "Ready to learn new things?",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white.withAlpha(204)),
                  )
                ],
              ));
  }

  Widget actionsContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Maby change this into "Quik actions" not sure yet
        Text("Actions", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: actionButton(
                context,
                "Public flashcards",
                Icons.public,
                () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayFlashcardSets()));
                },
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(child: actionButton(context, "My sets", Icons.folder, () {}))
          ],
        )
      ],
    );
  }

  Widget actionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback ontap,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            // color: Colors.white,
            color: Colors.grey[100], //giving bit of grey tint
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 10, offset: Offset(0, 4))]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: Color(0xFF6448FE),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6448FE),
              ),
            )
          ],
        ),
      ),
    );
  }

//* Create custom color picker.  Existing color picker tool  is not good to use with predfined gradient colors
  Future<void> customColorPickerDialog() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a theme'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: themeGradients.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   currentGradient = entry.value;
                    // });
                    themeProvider.updateTheme(entry.value);

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: entry.value,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
