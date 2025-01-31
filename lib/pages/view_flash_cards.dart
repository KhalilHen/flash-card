import 'package:flash_card_app/models/flashcard_sets.dart';
import 'package:flash_card_app/pages/custom/custom_app_bar.dart';
import 'package:flash_card_app/style/theme_notifier.dart';
import 'package:flash_card_app/style/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewFlashCard extends StatefulWidget {
  final FlashCardSets flashcardSet;

  const ViewFlashCard({
    super.key,
    required this.flashcardSet,
  });

  @override
  State<ViewFlashCard> createState() => _ViewFlashCardState();
}

class _ViewFlashCardState extends State<ViewFlashCard> {
  LinearGradient currentGradient = oceanBlueGradient;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentGradient,
        ),
        child: Column(
          children: [
            CustomAppBar(
              title: "Flash card",
              onThemePressed: null,
              onThemePressed2: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        print("content:" + widget.flashcardSet.title);
      }),
    );
  }
}
