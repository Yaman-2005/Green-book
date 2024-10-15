import 'package:flutter/material.dart';
import 'package:testp/LogIn.dart';
class Settings extends StatefulWidget {
  final String username;
  const Settings({super.key,required this.username});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Visibility(visible: false,child: CircularProgressIndicator()),
            Visibility(child: Text('Fetching Summary...')),
            SizedBox(height: 100,),
            Text('current account: '+username),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>
                      const LogIn()), (Route<dynamic> route) => false),
                  child: const Text('Log Out',style: TextStyle(color: Colors.red),),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green)
                  ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
