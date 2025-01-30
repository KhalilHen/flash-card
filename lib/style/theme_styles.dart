import 'package:flutter/material.dart';

//!  Colors source:  https://www.b3multimedia.ie/beautiful-color-gradients-for-your-next-design-project/
//Main theme:
// Ocean blue theme
const Color oceanBlueStart = Color(0xFF6448FE);
const Color oceanBlueEnd = Color(0xFF5FC6FF);

// Sanguine theme
const Color sanguineStart = Color(0xFFD4145A);
const Color sanguineEnd = Color(0xFFFBB03B);

// Lucious Lime theme
const Color luciousLimeStart = Color(0xFF009245);
const Color luciousLimeEnd = Color(0xFFFCEE21);

// Green beach theme
const Color greenBeachStart = Color(0xFF02AABD);
const Color greenBeachEnd = Color(0xFF00CDAC);

// Mountain Rock theme
const Color mountainRockStart = Color(0xFF868F96);
const Color mountainRockEnd = Color(0xFF596164);

// No mans theme
const Color noMansStart = Color(0xFFA9F1DF);
const Color noMansEnd = Color(0xFFFFBBBB);

// Toxic theme
const Color toxicStart = Color(0xFFBFF098);
const Color toxicEnd = Color(0xFF6FD6FF);

// Exotic theme
const Color exoticStart = Color(0xFFFF61D2);
const Color exoticEnd = Color(0xFFFE9090);

// Cactus theme
const Color cactusStart = Color(0xFFC6EA8D);
const Color cactusEnd = Color(0xFFFE90AF);

// Socialive theme
const Color socialiveStart = Color(0xFF06BEB6);
const Color socialiveEnd = Color(0xFF48B1BF);

final LinearGradient oceanBlueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [oceanBlueStart, oceanBlueEnd],
);

final LinearGradient sanguineGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [sanguineStart, sanguineEnd],
);

final LinearGradient luciousLimeGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [luciousLimeStart, luciousLimeEnd],
);

final LinearGradient greenBeachGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [greenBeachStart, greenBeachEnd],
);

final LinearGradient mountainRockGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [mountainRockStart, mountainRockEnd],
);

final LinearGradient noMansGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [noMansStart, noMansEnd],
);

final LinearGradient toxicGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [toxicStart, toxicEnd],
);

final LinearGradient exoticGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [exoticStart, exoticEnd],
);

final LinearGradient cactusGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [cactusStart, cactusEnd],
);

final LinearGradient socialiveGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [socialiveStart, socialiveEnd],
);


final Map<String, LinearGradient> themeGradients = {

   "Ocean Blue": oceanBlueGradient,
  "Sanguine": sanguineGradient,
  "Lucious Lime": luciousLimeGradient,
  "Green Beach": greenBeachGradient,
  "Mountain Rock": mountainRockGradient,
  "No Mans": noMansGradient,
  "Toxic": toxicGradient,
  "Exotic": exoticGradient,
  "Cactus": cactusGradient,
  "Socialive": socialiveGradient,
};
