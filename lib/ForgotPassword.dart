import 'package:flutter/material.dart';
import 'package:testp/mongodb.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _doObscure = true,CPI = false,isError = false;
  late String user='',secans='',error='',passwordShow='';
  Future<void> getPassword(String user,String answer) async {
    setState(() {
      CPI = true;
    });
    String password = await mongodb.forgotPassword(user, answer);
    setState(() {
      CPI = false;
      isError = true;
      passwordShow = password;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recover Password'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('Enter the'),
            const Text('Username and Answer to the security question',style: TextStyle(fontStyle: FontStyle.italic),),
            const Text('to fetch the password.'),
            const Text('If you dont have that, create a new account.'),
            const SizedBox(height: 35,),
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
            const SizedBox(height: 20,),
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
                  hintText: 'Enter Answer',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => secans = value,
            ),
            const SizedBox(height: 35,),
            Visibility(visible: CPI,child: const CircularProgressIndicator(),),
            Visibility(visible: isError,child: Text('Password is: $passwordShow')),
            const SizedBox(height: 35,),
            ElevatedButton(onPressed: () => getPassword(user,secans),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)), child: const Text('Fetch Password'),),


          ],
        ),
      ),
    );
  }
}
