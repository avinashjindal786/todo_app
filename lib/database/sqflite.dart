
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class databasehelper
{

  static final _databasename= "Avinash.db";
  static final _dtabaseversion = 1;
  static final table = "my_tale";
  static final columnID = 'tittle';
  static final columnName = 'decription';


  static Database? _database;

  databasehelper.init();
  static final databasehelper instance = databasehelper.init();

  Future<Database> get database async
  {
    if(_database != null)


    {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async
  {
    final datapath = await getDatabasesPath();
    final path = join(datapath, _databasename);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $table ( 
      $columnID TEXT NOT NULL, 
      $columnName TEXT NOT NULL,
      
  
      )
      ''');
  }

  Future<int> insert(Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String,dynamic>>> Queryall() async{
    Database db = await instance.database;
    return await db.query(table);
  }


}