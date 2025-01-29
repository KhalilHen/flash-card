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
          // SizedBox(height: 24,), 
          Expanded(
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                welcomeContainer(),
                SizedBox(height: 24,),
                actionsContainer(context),

              ],
              
            ),
          ),)
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

    // TODO Add here a iconbutton to change the   theme style.
      // IconButton(onPressed: () {}, icon: Icon(Icons.circle_)),
          CircleAvatar(
                backgroundColor: Colors.white.withAlpha(77),

              child: IconButton(onPressed: () {}, icon:  Icon(Icons.person), ),
          )
      
        ],
      ),
    );
  }

  Widget welcomeContainer() {

     return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO Later add when user is logged in output: "Welcome back" else just "Welcome"
          Text("Welcom back", style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),)
,
            Text("Ready to continue learning?", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white.withAlpha(204)),)


        ],
      ),
     );
  }


   Widget actionsContainer(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       //* Maby change this into "Quik actions" not sure yet 
        Text("Actions", style: GoogleFonts.poppins(fontSize: 20, color: Colors.white,  fontWeight: FontWeight.bold))
      ,
        SizedBox(height: 30,)
      , Row(

        children: [
          Expanded(child:  actionButton(context, "Public flashcards", Icons.public , () {} ,    ),), 

        ],
      )
      ],
    );
  }
  Widget actionButton(BuildContext context, String title,  IconData icon, VoidCallback ontap,) {


    return GestureDetector(

      onTap: ontap, 
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.circular(16),
          boxShadow: [

            BoxShadow(color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4)
            )


          ]
        ),
child: Column(
  mainAxisSize:  MainAxisSize.min,

  children: [
    Icon(icon, size: 32,
    
                  color: Color(0xFF6448FE),

    ),
    SizedBox(height: 12,),
    Text(title, style:  GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,                 color: Color(0xFF6448FE),
 ),)
  ],
),
      ),
    );
  }
 

}