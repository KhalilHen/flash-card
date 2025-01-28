import 'package:flash_card_app/controllers/flashcard_controller.dart';
import 'package:flash_card_app/models/flashcard_model.dart';
import 'package:flutter/material.dart';


class CreateFlashCard extends StatefulWidget {
  const CreateFlashCard({Key? key}) : super(key: key);

  @override
  State<CreateFlashCard> createState() => _CreateFlashCardState();
}

class _CreateFlashCardState extends State<CreateFlashCard> {

  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final flashCardController = FlashcardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flashcard'),
      ),
      body:  SingleChildScrollView(
        child: Center(
            child: Form(
              key: formKey,
              child: Column(


              children: [

                Text("Create Flashcard", style: TextStyle(fontSize: 20),),

                SizedBox(height: 20,),

                TextFormField(  
                  controller: questionController,

                  decoration: InputDecoration(
                    labelText: 'Question',
                  ),
    
                
 
                ),

                SizedBox(height: 20,),
      TextFormField(
          controller: answerController,
                  decoration: InputDecoration(
                    labelText: 'Answer',
                  ),
    
                
 
                ),

                SizedBox(height: 20,),




                ElevatedButton(onPressed: (){

                    flashCardController.createFlashCard(
                      context, 
                      questionController.text, 
                      answerController.text
                    );

                }, child: Text('Create Flashcard')
      )
              ],
            )),


        ),
      ),
    );
  }
}