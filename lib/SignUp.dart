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
  late String user='',pass='',error='',secans='';
  List<String> secques = ['What was the name of your first pet?','What was the name of your favorite food as a child?','What was the name of your high school?','What city were you born in?','What is your favorite sport?'];
  bool _doObscure = true,CPI = false,isError = false,_doObscure1 = true;
  late String question;
  Future<void> addUserName(String username,String password,String secans,String secques) async {
    setState(() {
      CPI = true;
    });
    if(await mongodb.signUpUsernameExists(username)) {
      setState(() {
        CPI = false;
        error =
        'This username belongs to someone else,or the password is not unique';
      });
    }
    else {
      dict sender = {
        'username': username,
        'password': password,
        'question' : secques,
        'answer' : secans,
      };
      mongodb.registerMasterDetails(sender);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
          const MyApp()), (Route<dynamic> route) => false);
      print('done');
    }
  }
  @override
  Widget build(BuildContext context) {
    question = (secques.toList()..shuffle()).first;
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
            Text('Security Question:$question',style: const TextStyle(fontSize: 15,),),
            const SizedBox(height: 25,),
            TextField(
              obscureText: _doObscure,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _doObscure1 = !_doObscure1;
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
            Visibility(visible: CPI,child: CircularProgressIndicator()),
            Visibility(
                visible: true,
                child: Text(error)
            ),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed: () => addUserName(user,pass,secans,question),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)), child: const Text('Sign Up'),),
            const Text('Note:\nRemember the answer to the security question,\nin case you lose your password',style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}
