// ignore_for_file: constant_identifier_names, camel_case_types

import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
const MONGO_URL = "mongodb+srv://getananmay:abcdefghij@cluster0.20fy8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const COLLECTION = "passwords.data";
typedef dict = Map<String,dynamic>;
class mongodb {
  static connect() async {
    var db = await  Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    db.collection(COLLECTION);
  }
  static registerPassword(dict data) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    collection.insertOne(data);
  }
  static Future<dict?> searchTag(String tag) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    Map<String, dynamic>? ans = await collection.findOne({"tag":tag});
    return ans;
  }
  static void updatePassword(String tag,String password) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(where.eq('tag', tag), modify.set('password', password));
  }
  static void updatePPassword(String tag,String password) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(where.eq('tag', tag), modify.set('Ppassword', password));
  }
  static void updateTPassword(String tag,String password) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.update(where.eq('tag', tag), modify.set('Tpassword', password));
  }
  static void deletePassword(String tag) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION);
    await collection.deleteOne({'tag':tag});
  }
}