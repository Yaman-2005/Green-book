// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'mongodb.dart';
typedef dict = Map<String, dynamic>;
class AddNewBank extends StatefulWidget {
  const AddNewBank({super.key});

  @override
  State<AddNewBank> createState() => _AddNewBankState();
}

class _AddNewBankState extends State<AddNewBank> {
  late String tag,website,password,Tpassword,Ppassword;
  dict throwData() {
    dict ans = {
      "tag" : tag,
      "website" : website,
      "password" : password,
      "isBank" : true,
      "Tpassword" : Tpassword,
      "Ppassword" : Ppassword,
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
    return Scaffold(
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  onChanged: (value) => Tpassword = value,
                  decoration: InputDecoration(
                      hintText: 'Enter Transaction password',
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  onChanged: (value) => Ppassword = value,
                  decoration: InputDecoration(
                      hintText: 'Enter Profile password',
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
