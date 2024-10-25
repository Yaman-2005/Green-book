import 'package:flutter/material.dart';
import 'package:testp/ChangePassword.dart';
import 'package:testp/LogIn.dart';
import 'package:testp/ReviewSecurityQuestion.dart';
import 'package:testp/main.dart';
import 'package:testp/mongodb.dart';
import 'viewPass.dart';
class Settings extends StatefulWidget {
  final String username;
  const Settings({super.key,required this.username});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool CPI=false,bInfo=false,bButton=true;
  late String info='';
  Future<void> accSummary(String username) async {
    setState(() {
      bButton = false;
      CPI = true;
    });
    dict? data = await mongodb.getData(username);
    if(data == null) {
      setState(() {
        CPI = false;
        bInfo = true;
        info = 'An error occurred. Please try again';
        bButton = true;
      });
    }
    else {
      String count = data['passwords'];
      String master = data['master'];
      String question = data['question'];
      String answer = data['answer'];
      setState(() {
        CPI = false;
        bInfo = true;
        info = 'Passwords Stored: $count\nMaster Password: ${master.substring(0,2)}*****\nSecurity Question:${question.substring(0,7)}*****\nSecurity Answer:${answer.substring(0,1)}*****';
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Text('account: $username',style: TextStyle(fontSize: 30),),
            SizedBox(height: 50,),
            Visibility(visible:bButton,child: ElevatedButton(onPressed: () => accSummary(username),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)), child: const Text('Generate Account Summary'),)),
            Visibility(visible:CPI,child: CircularProgressIndicator()),
            Visibility(visible:bInfo,child: Text(info)),
            SizedBox(height: 400,),
            SizedBox(width: 10,),
            TextButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword(username: username,))),
              style: ButtonStyle(foregroundColor: const WidgetStatePropertyAll(Colors.green),overlayColor: WidgetStatePropertyAll(Colors.green[800])), child: const Row(
              children: [
                Icon(Icons.password),
                SizedBox(width: 80,),
                Text('Change Password'),
              ],
            ),
          ),
            /*TextButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ReviewSecurityQuestion())),
              style: ButtonStyle(foregroundColor: const WidgetStatePropertyAll(Colors.green),overlayColor: WidgetStatePropertyAll(Colors.green[800])), child: const Row(
              children: [
                Icon(Icons.password),
                SizedBox(width: 80,),
                Text('Review Security Question'),
              ],
            ),
            ),*/
            TextButton(onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.grey,
                    title: const Text('Log Out?'),
                    content: Text('This will log out of account '+username),
                    actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),),
          TextButton(onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
              const MyApp()), (Route<dynamic> route) => false), child: const Text('Log out'),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)))])),
              style: ButtonStyle(foregroundColor: const WidgetStatePropertyAll(Colors.red),overlayColor: WidgetStatePropertyAll(Colors.red[800])), child: const Row(
              children: [
                Icon(Icons.lock),
                SizedBox(width: 80,),
                Text('Log Out'),
              ],
            ),
            ),



          ],
        ),
      ),
    );
  }
}