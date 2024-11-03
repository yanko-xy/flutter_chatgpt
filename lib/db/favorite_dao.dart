import 'package:flutter_chatgpt/db/table_name.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';
import 'package:flutter_chatgpt/models/favorite_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IFavorite {
  Future<int?> addFavorite(FavoriteModel model);

  Future<int?> removeFavorite(FavoriteModel model);

  Future<List<FavoriteModel>> getFavoriteList();
}

class FavoriteDao implements IFavorite, ITable {
  final XYDBManager storage;

  @override
  String tableName = "tb_favorite";

  FavoriteDao(this.storage) {
    storage.db
        .execute("create table if not exists $tableName (id integer primary key autoincrement, "
            "ownerName text, content text, createdAt integer)");
  }

  @override
  Future<int?> addFavorite(FavoriteModel model) async {
    var result = await storage.db
        .insert(tableName, model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  @override
  Future<List<FavoriteModel>> getFavoriteList() async {
    var results = await storage.db.rawQuery("select * from $tableName order by id desc");
    var list = results.map((item) => FavoriteModel.fromJson(item)).toList();
    return list;
  }

  @override
  Future<int?> removeFavorite(FavoriteModel model) async {
    var result = await storage.db.delete(tableName, where: "id = ?", whereArgs: [model.id]);
    return result;
  }
}
