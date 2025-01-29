import 'package:flash_card_app/controllers/flashcard_set_controller.dart';
import 'package:flutter/material.dart';


class CreateFlashcardSet  extends StatefulWidget{

   CreateFlashcardSet({Key? key}) : super(key: key);

  @override
  State<CreateFlashcardSet> createState() => _CreateFlashcardSetState();
}

class _CreateFlashcardSetState extends State<CreateFlashcardSet> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final flashcardSetController = FlashcardSetController();

  bool isPublic = false;

  void   isPublicSet(bool value) {
    isPublic = value;
  }

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

                Row(
                  children: [
                  Checkbox(
                    value:  isPublic,
                    onChanged: (bool? value) {
                      setState(() {
                        
                          isPublic = value ?? false;

                      });

                    },
                  ),
                  const Text('Want your set to be public'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      String status = isPublic ? "public" : "private";
                      flashcardSetController.createFlashCardSet(context, titleController.text, status  );
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