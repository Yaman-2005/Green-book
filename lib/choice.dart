import 'package:flutter/material.dart';
import 'package:testp/addNew.dart';

import 'addNewBank.dart';
class Choice extends StatefulWidget {
  final collectionName;
  const Choice({super.key,required this.collectionName});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter type of password'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 250,),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)
                 ),
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AddNewBank(collectionName: collectionName,))),
                child: const Text('Netbanking/Bank details'),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)
                ),
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AddNew(collectionName: collectionName,))),
                child: const Text('General Password')
            )

          ],
        ),
      ),
    );
  }
}
