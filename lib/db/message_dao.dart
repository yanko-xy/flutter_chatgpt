// 消息表数据操作接口
import 'package:chat_message/models/message_model.dart';
import 'package:flutter_chatgpt/db/table_name.dart';
import 'package:flutter_chatgpt/db/xy_db_manager.dart';

abstract class IMessage {
  void saveMessage(MessageModel model);

  Future<int> deleteMessage(int id);

  void update(MessageModel model);

  Future<List<MessageModel>> getAllMessage();

  // 分页查询, pageIndex页码从1开始，pageSize每页显示的数据量
  Future<List<MessageModel>> getMessages({int pageIndex = 1, int pageSize = 20});

  Future<int> getMessageCount();
}

class MessageDao implements IMessage, ITable {
  final XYDBManager storage;
  final int cid; // 会话id

  @override
  String tableName = "";

  MessageDao(this.storage, {required this.cid}) : tableName = tableNameByCid(cid) {
    storage.db.execute(
        "create table if not exists $tableName (id integer primary key autoincrement, content text,"
        "createdAt integer, ownerName text, ownerType text, avatar text)");
  }

  // 获取带cid的表名称
  static String tableNameByCid(int cid) {
    return "tb_$cid";
  }

  @override
  Future<int> deleteMessage(int id) {
    return storage.db.delete(tableName, where: "id=$id");
  }

  @override
  Future<List<MessageModel>> getAllMessage() async {
    var results = await storage.db.rawQuery("select * from $tableName order by id asc");
    var list = results.map((item) => MessageModel.fromJson(item)).toList();
    return list;
  }

  @override
  Future<List<MessageModel>> getMessages({int pageIndex = 1, int pageSize = 20}) async {
    var offset = (pageIndex - 1) * pageSize;
    var results = await storage.db
        .rawQuery("select * from $tableName order by id desc limit $pageSize offset $offset");
    var list = results.map((item) => MessageModel.fromJson(item)).toList();
    // 反转列表已适应分页查询
    return List.from(list.reversed);
  }

  @override
  Future<int> getMessageCount() async {
    var result = await storage.db.query(tableName, columns: ["COUNT(*) as cnt"]);
    return result.first["cnt"] as int;
  }

  @override
  void saveMessage(MessageModel model) {
    storage.db.insert(tableName, model.toJson());
  }

  @override
  void update(MessageModel model) {
    storage.db.update(tableName, model.toJson(), where: "id = ?", whereArgs: [model.id]);
  }
}
