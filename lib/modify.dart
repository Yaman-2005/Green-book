// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:testp/mongodb.dart';
class Modify extends StatefulWidget {
  final String tag;
  final bool isBank;
  const Modify({super.key, required this.tag,required this.isBank});

  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  late String newPass = "",pass,newPpass = "",Ppass,newTpass = "",Tpass;
  Future<void> updateDb(String tag,String pass,bool isBank,String Tpass,String Ppass) async {
    if(isBank == false) {
      mongodb.updatePassword(tag, pass);
      Navigator.pop(context);
    }
    else {
      if(pass != "") {
        mongodb.updatePassword(tag, pass);
      }
      if(Tpass != "") {
        mongodb.updateTPassword(tag, Tpass);
      }
      if(Ppass != "") {
        mongodb.updatePPassword(tag, Ppass);
      }
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    String tag = widget.tag;
    bool isBank = widget.isBank;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modify '+tag
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          TextField(
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: 'Enter new password',

              hintStyle: TextStyle(
                color: Colors.grey
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(
              color: Colors.black
            ),
            onChanged: (value) => newPass = value,
          ),
          Visibility(visible: isBank,child: const SizedBox(height: 50,)),
          Visibility(
            visible: isBank,
            child: TextField(
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: 'Enter new Transaction password',

                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(
                  color: Colors.black
              ),
              onChanged: (value) => newTpass = value,
            ),
          ),
          Visibility(visible: isBank,child: const SizedBox(height: 50,)),
          Visibility(
            visible: isBank,
            child: TextField(
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: 'Enter new Profile password',

                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(
                  color: Colors.black
              ),
              onChanged: (value) => newPpass = value,
            ),
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)
              ),
              onPressed: () => updateDb(tag,newPass,isBank,newTpass,newPpass),
              child: const Text('Update new password')
          )
        ],
      ),
    );
  }
}
