import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/repository/base_token_repository.dart';

class TokenRepository implements BaseTokenRepository {
  String? _token;
  Map<String, dynamic>? _cachedTokenData;
  final FlutterSecureStorage _storage;

  TokenRepository(this._storage);

  @override
  String? getToken() => _token;

  @override
  Future<String?> getTokenFromStorage() async {
    try {
      final token = await _storage.read(key: TOKEN_KEY);
      if (token != null && token.isNotEmpty) {
        _token = token;
        _loadCachedData();
      }
      return token;
    } catch (e) {
      _log('getTokenFromStorage error: $e');
      return null;
    }
  }

  @override
  Future<void> set({required String? token, UserModel? user}) async {
    // If token is null => treat as clear (hard stop on partial states)
    if (token == null || token.isEmpty) {
      await clear();
      return;
    }

    _token = token;
    try {
      await _storage.write(key: TOKEN_KEY, value: token);
      if (user != null) {
        await saveUser(user);
      }
      _loadCachedData();
    } catch (e) {
      _log('set error: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await _storage.write(key: USER_KEY, value: jsonEncode(user.toJson()));
    } catch (e) {
      _log('saveUser error: $e');
    }
  }

  Future<UserModel?> getUserFromStorage() async {
    try {
      final userString = await _storage.read(key: USER_KEY);
      if (userString == null || userString.isEmpty) return null;
      final map = jsonDecode(userString);
      return UserModel.fromJson(map);
    } catch (e) {
      _log('getUserFromStorage error: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? decode() {
    if (_token == null || _token!.isEmpty) return null;
    try {
      final decoded = JwtDecoder.decode(_token!);
      _cachedTokenData = decoded;
      return decoded;
    } catch (e) {
      _log('decode error: $e');
      return null;
    }
  }

  @override
  Future<bool> checkExpiration() async {
    if (_token == null || _token!.isEmpty) return true;
    try {
      final expired = JwtDecoder.isExpired(_token!);
      if (expired) {
        await _clearPersistedData();
        _clearMemory();
      }
      return expired;
    } catch (e) {
      _log('checkExpiration error: $e');
      return true; // defensive: treat as expired
    }
  }

  @override
  Future<void> clear() async {
    try {
      _clearMemory();
      await _clearPersistedData();
      _log('Token cleared successfully');
    } catch (e) {
      _log('clear error: $e');
    }
  }

  Future<void> logout() => clear();

  @override
  Map<String, dynamic>? getCachedTokenData() {
    if (_cachedTokenData == null && _token != null && _token!.isNotEmpty) {
      decode();
    }
    return _cachedTokenData;
  }

  Future<bool> isTokenValid() async {
    if (_token == null || _token!.isEmpty) return false;
    if (await checkExpiration()) return false;
    final data = getCachedTokenData();
    return data != null && data.isNotEmpty;
  }

  // ---- Internals ----

  void _loadCachedData() {
    if (_token != null && _token!.isNotEmpty) {
      decode();
    }
  }

  void _clearMemory() {
    _token = null;
    _cachedTokenData = null;
  }

  Future<void> _clearPersistedData() async {
    await Future.wait([
      _storage.delete(key: TOKEN_KEY),
      _storage.delete(key: USER_KEY),
    ]);
  }

  void _log(Object o) {
    // replace with your logger if needed
    debugPrint('$o');
  }
}
