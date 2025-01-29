import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:  Container(
       decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft,  end: Alignment.bottomRight, colors: [

           Color(0xFF6448FE),
              Color(0xFF5FC6FF),
        ])
       ),
       //Safeare to prevent different mobile device having different screen
    child: SafeArea(
      
      child: Column(
        children: [
          customAppBar(),
        ],
      )
      
      ),
      ),
    
    );
  }
  //Custom app bar 
  Widget customAppBar() {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Flashcard App", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),

          CircleAvatar(
                backgroundColor: Colors.white.withAlpha(77),

              child: IconButton(onPressed: () {}, icon:  Icon(Icons.person), ),
          )
      
        ],
      ),
    );
  }
}