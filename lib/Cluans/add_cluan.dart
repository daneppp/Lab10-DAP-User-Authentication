// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cluans_model.dart';
import 'cluans.dart';
/**
 * Name: Dane Patzlaff
 * Date: 10/12/25
 * Description: Contains the add Cluan TextControllers and displays the Textfields for the user to interact with 
 * Known Bugs: None
 * Reflection: I searched how to get a bottom level confirmation/error message and discovered ScaffoldMessenger.of()showSnackBar
 * which I used to display when a Cluan could/couldn't be successfully added
 */

class AddCluanWidget extends StatefulWidget {
  const AddCluanWidget({super.key});

  @override
  State<AddCluanWidget> createState() => _AddCluanWidgetState();
}

//Set up the TextFieldControllers
class _AddCluanWidgetState extends State<AddCluanWidget> {
  final TextEditingController clueController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  //Add the cluan's clue and answer if valid and output a message if successful/unsuccessful
  void _addCluan(BuildContext context) {
    String clue = clueController.text.trim();
    String answer = answerController.text.trim();

    if (clue.isEmpty || answer.length < 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid clue or answer.')));
      return;
    }

    //Construct the new Cluan and call context.read to update the CluansModel
    final newCluan = Cluans(clue: clue, answer: answer, date: DateTime.now());

    context.read<CluansModel>().addCluan(newCluan);
    context.read<CluansModel>().notifyListeners();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Cluan added successfully!')));
  }

  //Clears the textfields
  void _clearFields() {
    clueController.clear();
    answerController.clear();
  }

  //Displays the textfields for the clue and answer and the add cluan, clear textfields, and test addition buttons
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: clueController,
            decoration: const InputDecoration(labelText: 'Clue'),
          ),
          TextField(
            controller: answerController,
            decoration: const InputDecoration(labelText: 'Answer'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _addCluan(context),
                child: const Text('Add Cluan'),
              ),
              ElevatedButton(
                onPressed: _clearFields,
                child: const Text('Clear Fields'),
              ),
              ElevatedButton(
                onPressed: () {
                  final testCluan = Cluans(
                    clue: 'Test clue from button',
                    answer: 'flutter',
                    date: DateTime.now(),
                  );
                  context.read<CluansModel>().addCluan(testCluan);
                  context.read<CluansModel>().notifyListeners();
                },
                child: const Text('Test Addition'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
