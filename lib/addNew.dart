// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'mongodb.dart';
typedef dict = Map<String, dynamic>;
class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  late String tag,website,password;
  dict throwData() {
    dict ans = {
      "tag" : tag,
      "website" : website,
      "password" : password,
      "isBank" : false
    };
    return ans;
  }
  void sendToDb() {
    dict send = throwData();
    mongodb.registerPassword(send);
    Navigator.pop(context);
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Setup a new password"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: TextField(
                cursorColor: Colors.black,
                onChanged: (value) => tag = value,
                decoration: InputDecoration(
                    hintText: 'Enter Tag for the password',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.white,
                    icon: const Icon(
                      Icons.tag,
                      color: Colors.white,
                    )
                ),
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: TextField(
                cursorColor: Colors.black,
                onChanged: (value) => website = value,
                decoration: InputDecoration(
                    hintText: 'Enter name of website',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.white,
                    icon: const Icon(
                      Icons.http,
                      color: Colors.white,
                    )
                ),
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            const SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: TextField(
                cursorColor: Colors.black,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                    hintText: 'Enter password',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.white,
                    icon: const Icon(
                      Icons.password,
                      color: Colors.white,
                    )
                ),
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                onPressed: sendToDb, child: const Text('Add Password')
            )
          ],
        ),
      )
    );
  }
}
