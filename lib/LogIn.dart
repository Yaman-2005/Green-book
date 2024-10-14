import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String user,pass;
  bool _doObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in to GreenBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 120,),
            TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Username',
                hintStyle: TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) => user = value,
            ),
            const SizedBox(height: 50,),
            TextField(
              obscureText: _doObscure,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {setState(() {
                    _doObscure = !_doObscure;
                  });},  icon: const Icon(Icons.remove_red_eye),color: Colors.black,),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter Password',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => pass = value,
            ),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed: () {}, child: const Text('Log In'))
          ],
        ),
      ),
    );
  }
}