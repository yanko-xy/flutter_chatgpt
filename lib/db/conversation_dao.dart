import 'dart:convert';

import 'package:flutter_chatgpt/db/message_dao.dart';
import 'package:flutter_chatgpt/db/table_name.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';
import 'package:flutter_chatgpt/models/conversation_model.dart';
import 'package:openai_flutter/utils/ai_logger.dart';
import 'package:sqflite/sqflite.dart';

abstract class IConversationList {
  // 保存会话并返回数据库记录的id
  Future<int?> saveConversation(ConversationModel model);

  void deleteConversation(ConversationModel model);

  // 分页查询
  Future<List<ConversationModel>> getConversationList({pageIndex = 1, pageSize = 20});

  // 置顶与取消置顶
  Future<int> updatgeStickTime(ConversationModel model, {bool isStick = false});

  // 查询置顶的会话
  Future<List<ConversationModel>> getStickConversationList();
}

class ConversationListDao implements IConversationList, ITable {
  final XYDBManager storage;

  ConversationListDao(this.storage) {
    // 创建表
    storage.db
        .execute("create table if not exists $tableName (id integer primary key autoincrement,"
            "cid integer, title text, icon text, updatedAt integer,"
            "messageCount integer, lastMessage text, stickTime integer)");
    // 创建唯一索引
    storage.db
        .execute("create unique index if not exists ${tableName}_cid_idx on $tableName (cid)");
  }

  @override
  String tableName = "tb_conversation_list";

  @override
  void deleteConversation(ConversationModel model) {
    // 删除聊天列表记录
    if (model.id == null) {
      storage.db.delete(tableName, where: "cid=${model.cid}");
    } else {
      storage.db.delete(tableName, where: "id=${model.id}");
    }

    // 删除对应聊天记录
    storage.db.execute("drop table if exists ${MessageDao.tableNameByCid(model.cid)}");
  }

  @override
  Future<List<ConversationModel>> getConversationList({pageIndex = 1, pageSize = 20}) async {
    var offset = (pageIndex - 1) * pageSize;
    var results =
        await storage.db.rawQuery("select * from $tableName where cast(stickTime as integer) <= 0 "
            "order by updatedAt desc limit $pageSize offset $offset");

    var list = results.map((item) => ConversationModel.fromJson(item)).toList();
    AILogger.log("count:${list.length}");
    AILogger.log(jsonEncode(list));
    return list;
  }

  @override
  Future<int?> saveConversation(ConversationModel model) async {
    await storage.db
        .insert(tableName, model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    var result = await storage.db.query(tableName, where: "cid=${model.cid}");
    var resultModel = ConversationModel.fromJson(result.first);
    // 解决新建的会话没有id的问题
    if (resultModel.id != null) {
      model.id = resultModel.id;
    }
    return resultModel.id;
  }

  @override
  Future<List<ConversationModel>> getStickConversationList() async {
    var results =
        await storage.db.rawQuery("select * from $tableName where cast(stickTime as integer) > 0 "
            "order by stickTime desc");

    var list = results.map((item) => ConversationModel.fromJson(item)).toList();
    return list;
  }

  @override
  Future<int> updatgeStickTime(ConversationModel model, {bool isStick = false}) {
    if (isStick) {
      model.stickTime = DateTime.now().millisecondsSinceEpoch;
    } else {
      model.stickTime = 0;
    }
    // 当唯一键冲突时，仅更新没有冲突的字段
    return storage.db
        .update(tableName, model.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
