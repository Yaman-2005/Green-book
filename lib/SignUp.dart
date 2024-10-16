import 'package:flutter/material.dart';
import 'package:testp/main.dart';
import 'package:testp/mongodb.dart';
typedef dict = Map<String,dynamic>;
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String user='',pass='',error='';
  bool _doObscure = true,CPI = false,isError = false;
  void addUserName(String username,String password) {
    if(username == '') {
      setState(() {
        error = 'Enter a valid username';
      });
    }
    else if(password == '') {
      setState(() {
        error = 'Enter a valid password';
      });
    }
    dict sender = {
      'username':username,
      'password':password
    };
    mongodb.registerMasterDetails(sender);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>
        const MyApp()), (Route<dynamic> route) => false);
    print('done');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up to GreenBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
            ElevatedButton(onPressed: () => addUserName(user,pass),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)), child: const Text('Sign Up'),)
          ],
        ),
      ),
    );
  }
}
