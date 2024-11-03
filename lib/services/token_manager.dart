import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  TokenManager._();

  String _accessToken = "";
  String _refreshToken = "";

  final storage = const FlutterSecureStorage();

  static final TokenManager _instance = TokenManager._();

  factory TokenManager() {
    return _instance;
  }

  Future<void> initialize() async {
    _accessToken = await storage.read(key: "accessToken") as String;
  }

  Future<void> setAccessToken(token) async {
    await storage.write(key: "accessToken", value: token) as String;
  }

  get accessToken => _accessToken;

}