// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:testp/SignUp.dart';
import 'package:testp/choice.dart';
import 'package:testp/modify.dart';
import 'package:testp/mongodb.dart';
import 'package:testp/viewPass.dart';

import 'LogIn.dart';
typedef dict = Map<String,dynamic>;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  final _pageOptions = [const LogIn(),const SignUp()];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GreenBook Experimental',
        theme: ThemeData(
          colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.lightBlueAccent,
          onSecondary: Colors.white,
          error: Colors.transparent,
          onError: Colors.red,
          surface: Colors.black12,
          onSurface: Colors.white,
          )
        ),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: _pageOptions[selectedPage],
              bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: Colors.green,
                  items: const [BottomNavigationBarItem(
                      icon: Icon(Icons.login),
                      label: 'Log In'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.lock_open),
                      label: 'Sign Up'
                  )
                ],
                currentIndex: selectedPage,
                onTap: (index) {
                    setState(() {
                      selectedPage = index;
                    });
                },
              )
           );
          }
        )

    );
  }
}


