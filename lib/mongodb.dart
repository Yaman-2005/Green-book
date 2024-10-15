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
}