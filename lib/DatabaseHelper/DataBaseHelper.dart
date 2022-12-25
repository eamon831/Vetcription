
import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vetcription/Model/Disease.dart';
import 'package:vetcription/Model/Medicine.dart';

class DatabaseHelper{
  static final String _DB_NAME = 'vetcription_db.sqlite';
  static final _DB_VERSION = 1;
  static final table_medicine = 'vet_data';
  static var status = '';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _DB_NAME);

    //Check existing
    var exists = await databaseExists(path);
    if (!exists) {
      status = "Creating Database";

      //If not exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //copy database
      ByteData data = await rootBundle.load(join("assets/db", _DB_NAME));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Write
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      status = "Opening existing database";
      print('Opening existing database');
    }

    return await openDatabase(path, version: _DB_VERSION);
  }
  //Insert Single Item
  Future<int> insert(Map<String, dynamic> row, String tbl) async {
    Database db = await instance.database;
    return await db.insert(tbl, row,conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  //Insert A Medicine List
  Future<int> insertAllMedicine(List<Medicine> row) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    row.forEach((element) {
      Medicine medicine = Medicine.fromJson(element.toJson());
      batch.insert(table_medicine, medicine.toJson());
    });

    batch.commit(continueOnError: true, noResult: true);
  }

  //Get Everything From Table
  Future<List> getAll(String tbl) async {
    Database db = await instance.database;
    var result = await db.query(tbl);
    return result.toList();
  }
  Future<List<Disease>> diseaseSearch(String filterCriteria) async {
    Database db = await instance.database;
    List<Disease> filteredCompanies = [];
    var  res = await db.query(
        "disease_data",
        where: "name LIKE ? or description LIKE ?",
        whereArgs: ['%$filterCriteria%','%$filterCriteria%']
    );

    if(res.length !=null){
      //toast(res.length.toString());
      for (var item in res){
        filteredCompanies.add(Disease.fromJson(item));
      }

    }
    return filteredCompanies;
  }
  Future<List<Medicine>> medicineSearch(String filterCriteria) async {
    Database db = await instance.database;
    List<Medicine> filteredMedicine = [];
    var  res = await db.query(
        "vet_data",
        where: "trade_name LIKE ? or generic_name LIKE ?",
        whereArgs: ['%$filterCriteria%','%$filterCriteria%']
    );

    if(res.length !=null){
    //  toast(res.length.toString());
      for (var item in res){
        filteredMedicine.add(Medicine.fromJson(item));
      }

    }
    return filteredMedicine;
  }
  Future<List<Medicine>> savedMedicineSearch(String filterCriteria) async {
    Database db = await instance.database;
    List<Medicine> filteredMedicine = [];
    var  res = await db.query(
        "saved_data",
        where: "trade_name LIKE ? or generic_name LIKE ?",
        whereArgs: ['%$filterCriteria%','%$filterCriteria%']
    );

    if(res.length !=null){
    //  toast(res.length.toString());
      for (var item in res){
        filteredMedicine.add(Medicine.fromJson(item));
      }

    }
    return filteredMedicine;
  }




}