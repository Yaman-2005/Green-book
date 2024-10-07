// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testp/choice.dart';
import 'package:testp/modify.dart';
import 'package:testp/mongodb.dart';
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
  bool checker = false,checkerIndicator = false,chekerButton = true,checkButtonNull = true,isBank = false;
  late String search = "", website = "", password = "",Tpassword = "",Ppassword = "",newWebsite = "",newPassword = "",newTpassword = "",newPpassword = "";
  void Results(String tag) async {
    setState(() {
      checkerIndicator = true;
      checker = false;
    });
    dict? query = await mongodb.searchTag(search);
    if(query != null) {
      newWebsite = "Website: " +query["website"];
      newPassword = "Password: "+query["password"];
      if(query["isBank"] == true) {
        setState(() {
          isBank = true;
        });
        newPpassword = "Profile Password: "+query["Ppassword"];
        newTpassword = "Transaction Password: "+query["Tpassword"];
      }
      else {
        setState(() {
          isBank = false;
        });
        newPpassword = "";
        newTpassword = "";
      }
    }
    else {
      chekerButton = false;
      newWebsite = "Tag Not found in database";
      newPassword = "";
    }
    setState(() {
      checker = true;
      checkerIndicator = false;
      if(chekerButton == false) {
        checkButtonNull = false;
      }
      website = newWebsite;
      password = newPassword;
      Tpassword = newTpassword;
      Ppassword = newPpassword;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenBook',
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
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Greenbook'),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left:15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      'Search for saved passwords or create one using the radio button'
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      onChanged: (value) => search = value,
                      decoration: InputDecoration(
                        hintText: 'Enter name of tag',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: Colors.white,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )
                      ),
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  ElevatedButton(
                      onPressed: () => Results(search),
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      child: const Text('Search the geenbook')),
                  const SizedBox(height: 25,),
                  Visibility(
                    visible: checkerIndicator,
                    child: const CircularProgressIndicator(

                    ),
                  ),
                  Visibility(
                    visible: checker,
                    child: SizedBox(
                      width: 10000,
                      child: Column(
                        children: [
                          Text("Search results for "+search, style: const TextStyle(fontSize: 25),),
                          const SizedBox(height: 15,),
                          Text(website, style: const TextStyle(fontSize: 20,)),
                          const SizedBox(height: 15,),
                          Text(password, style: const TextStyle(fontSize: 20),),
                          const SizedBox(height: 15,),
                          Text(Tpassword, style: const TextStyle(fontSize: 20),),
                          const SizedBox(height: 15,),
                          Text(Ppassword, style: const TextStyle(fontSize: 20),),
                          const SizedBox(height: 15,),
                          Visibility(
                              visible: checkButtonNull,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(Colors.green)
                                  ),
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Modify(tag: search,isBank: isBank,))),
                                  child: Text("Modify "+search))
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton:  FloatingActionButton(
              backgroundColor: Colors.green,
                child: const Icon(
                    Icons.add,
                    color: Colors.white,
                ),
                onPressed:  () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Choice()),
                ),
            ),
          );
        }
      ),
    );
  }
}