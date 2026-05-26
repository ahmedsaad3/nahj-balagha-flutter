import 'package:nahj_balagha_flutter/core/network/result.dart';

abstract class BaseSqlHelper {
  Future<Result> get();
  Future<Result> create({required Map<String, dynamic> data});
  Future<Result> delete({required int id});
  Future<void> clearAll();
}
