import 'package:nahj_balagha_flutter/features/home/data/models/wisdom_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<WisdomModel> getWisdomOfTheDay();
}
