class UserModel {
  String? boardingPass;
  String? avatar;
  String? imoocId;
  String? userName;
  int? accountHash;

  UserModel({
    this.boardingPass,
    this.avatar,
    this.imoocId,
    this.userName,
    this.accountHash,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      boardingPass: json['boardingPass'],
      avatar: json['avatar'],
      imoocId: json['imoocId'],
      userName: json['userName'],
      accountHash: json['accountHash']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['boardingPass'] = boardingPass;
    data['avatar'] = avatar;
    data['imoocId'] = imoocId;
    data['userName'] = userName;
    data['accountHash'] = accountHash;
    return data;
  }
}
