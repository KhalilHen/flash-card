import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flutter/material.dart';


class CreateFlashcardSet  extends StatelessWidget{

   CreateFlashcardSet({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final flashcardSetController = FlashcardSetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flashcard Set'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text("Create Flashcard Set", style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      flashcardSetController.createFlashCardSet(context, titleController.text,);
                    }
                  },
                  child: const Text('Create Flashcard Set'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}