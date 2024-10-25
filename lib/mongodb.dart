// ignore_for_file: constant_identifier_names, camel_case_types

import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
var MONGO_URL = "mongodb+srv://getananmay:abcdefghij@cluster0.20fy8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const COLLECTION = "passwords.data";
const MASTER = "usernames";
typedef dict = Map<String,dynamic>;
class mongodb {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    db.collection(COLLECTION);
  }

  static registerPassword(dict data,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    collection.insertOne(data);
  }

  static Future<dict?> searchTag(String tag,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    Map<String, dynamic>? ans = await collection.findOne({"tag": tag});
    return ans;

  }

  static void updatePassword(String tag, String password,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(
        where.eq('tag', tag), modify.set('password', password));
  }

  static void updatePPassword(String tag, String password,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(
        where.eq('tag', tag), modify.set('Ppassword', password));
  }

  static void updateTPassword(String tag, String password,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(
        where.eq('tag', tag), modify.set('Tpassword', password));
  }

  static void deletePassword(String tag,String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.deleteOne({'tag': tag});
  }

  static Future<bool> userNameCheck(String username) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    Map<String, dynamic>? found = await collection.findOne(
        {'username': username});
    if (found == null) {
      return false;
    }
    else {
      return true;
    }

  }
  static Future<bool> passwordCheck(String password) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    Map<String, dynamic>? found = await collection.findOne(
        {'password': password});
    if (found == null) {
      return false;
    }
    else {
      return true;
    }
  }
  static Future<void> registerMasterDetails(dict data) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    collection.insertOne(data);
  }
  static Future<int> countMaster() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    int ans = await collection.count();
    return ans;
  }
  static Future<int> countSlave(String COLLECTION) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    int ans = await collection.count();
    return ans;
  }
  static Future<bool> signUpUsernameExists(String username) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    dict? checker = await collection.findOne({'username': username});
    if (checker == null) {
      return false;
    }
    else {
      return true;
    }
  }
  static Future<bool> signUpPasswordExists(String password) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    dict? checker = await collection.findOne({'password':password});
    if(checker == null) {
      return true;
    }
    else {
      return false;
    }
  }
  static Future<String> forgotPassword(String username,String answer) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    dict? collector = await collection.findOne({'username':username,'answer':answer});
    String password;
    print(collector);
    if(collector == null) {
      password = 'not found';
      return password;
    }
    else {
      password = collector['password'];
      return password;
    }
  }
  static Future<bool> changeMasterPassword(String username,String answer,String oldpassword,String newpassword) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    if(await collection.findOne({'username':username,'password':oldpassword,'answer':answer}) != null) {
      await collection.update(
          where.eq('username', username), modify.set('password', newpassword));
      return true;
    }
    return false;
  }
  static Future<String> getSecurityQuestion(String username) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    dict? info = await collection.findOne({'username':username});
    if(info == null)
      return '';
    return info['question'];
  }
  static Future<dict?> getData(String username) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(MASTER);
    dict? data = await collection.findOne({'username':username});
    if(data == null) {
      return null;
    }
    int count = await mongodb.countSlave(username);
    String password = data['password'];
    String question = data['question'];
    String answer = data['answer'];
    dict send = {
      'passwords' : count.toString(),
      'master' : password,
      'question' : question,
      'answer' : answer
    };
    return send;
  }
}