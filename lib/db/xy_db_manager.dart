// 用于管理数据库的创建和销毁
import 'package:flutter/widgets.dart';
import 'package:login_sdk/dao/login_dao.dart';
import 'package:sqflite/sqflite.dart';

class XYDBManager {
  // 多实例
  static final Map<String, XYDBManager> _storageMap = {};

  // 数据库名称
  final String _dbName;

  // 数据库实例
  late Database _db;

  // 获取实例
  static Future<XYDBManager> instance({required String dbName}) async {
    if (!dbName.endsWith(".db")) {
      dbName = "$dbName.db";
    }
    var storage = _storageMap[dbName];
    storage ??= await XYDBManager._(dbName: dbName)._init();
    return storage;
  }

  Database get db => _db;

  XYDBManager._({required String dbName}) : _dbName = dbName {
    _storageMap[_dbName] = this;
  }

  // 初始化数据库
  Future<XYDBManager> _init() async {
    _db = await openDatabase(_dbName);
    debugPrint("db version:${await _db.getVersion()}");
    return this;
  }

  // 销毁数据库
  void destroy() {
    _db.close();
    _storageMap.remove(_dbName);
  }

  // 账号唯一标识
  static String getAccountHash() {
    return LoginDao.getAccountHash() ?? "test";
  }
}
