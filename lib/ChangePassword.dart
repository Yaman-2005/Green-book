import 'package:flutter/material.dart';
import 'package:testp/mongodb.dart';
class ChangePassword extends StatefulWidget {
  final username;
  const ChangePassword({super.key,required this.username});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String oldPassword='',newPassword='',answer='',status='',error='';
  bool _doObscure1=true,_doObscure2=true,_doObscure3=true,CPI = false,isError = false,bStatus = false;
  Future<void> changePassword(String username,String op,String np,String ans) async {
    setState(() {
      CPI = true;
      status = 'Authenticating...';
      bStatus = true;
    });
    if(await mongodb.changeMasterPassword(username,ans,op,np) == true) {
      setState(() {
        CPI = false;
        status = 'Done!';
      });
      Navigator.pop(context);
      return;
    }
    setState(() {
      CPI = false;
      isError = true;
      error = 'An Error Occurred. Check your details';
    });

  }
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              obscureText: _doObscure1,
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
                  hintText: 'Enter Old Password',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => oldPassword = value,
            ),
            const SizedBox(height: 50,),
            TextField(
              obscureText: _doObscure2,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _doObscure2 = !_doObscure2;
                    });
                  },
                    icon: const Icon(Icons.remove_red_eye),color: Colors.black,),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter New Password',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => newPassword = value,
            ),
            const SizedBox(height: 50,),
            TextField(
              obscureText: _doObscure3,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {
                    setState(() {
                      _doObscure3 = !_doObscure3;
                    });
                  },
                    icon: const Icon(Icons.remove_red_eye),color: Colors.black,),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter Security Question Answer',
                  hintStyle: const TextStyle(color: Colors.grey)
              ),
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) => answer = value,
            ),
            const SizedBox(height: 20,),
            Visibility(visible:CPI,child: const CircularProgressIndicator()),
            const SizedBox(height: 20,),
            Visibility(visible:bStatus,child: Text(status)),
            const SizedBox(height: 20,),
            Visibility(visible:isError,child: Text(error)),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () => changePassword(username,oldPassword,newPassword,answer),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)) ,child: Text('Change Password')),

          ],
        ),
      ),
    );
  }
}
