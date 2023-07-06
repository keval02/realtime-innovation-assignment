
import 'dart:io';

import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider{

  late Database _database;


  Future openDb() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, "employees.db");

    // Directory docDirectory = await getApplicationDocumentsDirectory();
    _database = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE EmployeeModel(id INTEGER PRIMARY KEY autoincrement, employeeName TEXT, employeeRole TEXT, startDate TEXT, endDate TEXT)",
          );
        });
    return _database;
  }

  Future insertModel(EmployeeModel model) async {
    await openDb();
    return await _database.insert('EmployeeModel', model.toJson());
  }

  Future<List<EmployeeModel>> getModelList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('EmployeeModel');

    return List.generate(maps.length, (i) {
      return EmployeeModel(
          id: maps[i]['id'],
          employeeName: maps[i]['employeeName'],
          employeeRole: maps[i]['employeeRole'],
          startDate: maps[i]['startDate'],
          endDate: maps[i]['endDate'],
      );
    });

  }

  Future<int> updateModel(EmployeeModel model) async {
    print("Model:::${model}");
    await openDb();
    return await _database.update('EmployeeModel', model.toJson(),
        where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> deleteModel(EmployeeModel model) async {
    await openDb();
   return await _database.delete('EmployeeModel', where: "id = ?", whereArgs: [model.id]);
  }
}