import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

abstract class BaseTokenRepository {
  String? getToken();
  Future<String?> getTokenFromStorage();
  Future<void> set({required String? token, required UserModel? user});
  Future<void> saveUser(UserModel user);

  Future<void> clear();
  Map<String, dynamic>? decode();
  Future<bool> checkExpiration();
  Map<String, dynamic>? getCachedTokenData();
}
