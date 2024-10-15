import 'package:flutter/material.dart';
import 'package:testp/viewPass.dart';
import 'mongodb.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String user,pass,error='';
  bool _doObscure = true,CPI = false,isError = false;
  Future<void> checkUserName(String username,String password) async {
    setState(() {
      CPI = true;
    });
    if(await mongodb.userNameCheck(username) == false) {
        setState(() {
          CPI = false;
          isError = true;
          error = 'Username does not exist';
        });
    }
    else {
      if (await mongodb.passwordCheck(password) == false) {
        setState(() {
          CPI = false;
          isError = true;
          error = 'Incorrect password entered';
        });
      }
      else {
        setState(() {
          CPI = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                ViewPass(collectionName: username,)), (Route<dynamic> route) => false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in to GreenBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
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
                  color: Colors.black,
                ),
                onChanged: (value) => user = value,
              ),
              const SizedBox(height: 50,),
              TextField(
                obscureText: _doObscure,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          _doObscure = !_doObscure;
                        });
                      },
                    icon: const Icon(Icons.remove_red_eye),color: Colors.black,),
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
              Visibility(visible: CPI,child: CircularProgressIndicator()),
              Visibility(
                  visible: true,
                  child: Text(error)
              ),
              const SizedBox(height: 25,),
              ElevatedButton(
                  onPressed: () => checkUserName(user,pass),
                  child: const Text('Log In'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}