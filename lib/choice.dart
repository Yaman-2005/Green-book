import 'package:flutter/material.dart';
import 'package:testp/addNew.dart';

import 'addNewBank.dart';
class Choice extends StatelessWidget {
  const Choice({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const AddNewBank())),
                child: const Text('Netbanking/Bank details'),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)
                ),
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const AddNew())),
                child: const Text('General Password')
            )

          ],
        ),
      ),
    );
  }
}
