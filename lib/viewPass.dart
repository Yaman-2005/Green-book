// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'LogIn.dart';
import 'choice.dart';
import 'modify.dart';
import 'mongodb.dart';
class ViewPass extends StatefulWidget {
  final String collectionName;
  const ViewPass({super.key,required this.collectionName});

  @override
  State<ViewPass> createState() => _ViewPassState();
}

class _ViewPassState extends State<ViewPass> {

  bool checker = false,checkerIndicator = false,chekerButton = true,checkButtonNull = true,isBank = false,deleted=false;
  late String search = "", website = "", password = "",Tpassword = "",Ppassword = "",newWebsite = "",newPassword = "",newTpassword = "",newPpassword = "";
  void Results(String tag,String collectionName) async {
    setState(() {
      deleted = false;
      checkerIndicator = true;
      checker = false;
    });
    dict? query = await mongodb.searchTag(search,collectionName);
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
      else {
        checkButtonNull = true;
      }
      website = newWebsite;
      password = newPassword;
      Tpassword = newTpassword;
      Ppassword = newPpassword;
    });
  }
  void delete(String tag,String collectionName) {
    mongodb.deletePassword(tag,collectionName);
    setState(() {
      checker = false;
      checkButtonNull = false;
      deleted = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collectionName;
    return Builder(
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
                        onPressed: () => Results(search,collectionName),
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
                      visible: deleted,
                      child: Text(search+' was deleted'),
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
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Modify(tag: search,isBank: isBank,collectionName: collectionName,))),
                                    child: Text("Modify "+search))
                            ),
                            const SizedBox(height: 15,),
                            Visibility(
                                visible: checkButtonNull,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(Colors.red)
                                    ),
                                    onPressed: () => delete(search,collectionName),
                                    child: Text("Delete "+search))
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton:  Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed:  () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Choice(collectionName: collectionName,)),
                        ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        backgroundColor: Colors.green,
                        child: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed:  () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.grey,
                            title: const Text('Log Out?'),
                            content: Text('This will log out of account '+collectionName),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),),
                              TextButton(onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) =>
                                  const LogIn()), (Route<dynamic> route) => false), child: const Text('Log out'),
                                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                              )
                            ],
                          )


                        )
                        ),
                      ),
                    ),
                ]
              ),
            );
          }
      );
  }
}
