// this file is a helper to interact with the database using sql
// see the docs for all the query in the pub site and look for sqflite

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  // generic function to create the database
  static Future<sql.Database> database() async {
    // Get a db location using getDatabasesPath
    final databasesPath = await sql.getDatabasesPath();
    // .db is the extension of our database file (ex: places.db)
    String createdPath = path.join(databasesPath, 'places.db');

    // open the database
    return sql.openDatabase(
      version: 1,
      createdPath,
      onCreate: (sql.Database db, int version) async {
        // When creating the db, create the table
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
    );
  }

  // insert to database
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    // .insert to insert a data in database
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();

    // .query for getting data
    return db.query(table);
  }
}
