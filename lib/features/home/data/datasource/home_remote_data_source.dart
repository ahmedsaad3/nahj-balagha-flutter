import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/base_home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/data/models/wisdom_model.dart';

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  final DioClient _client;

  HomeRemoteDataSource({required DioClient client}) : _client = client;

  @override
  Future<WisdomModel> getWisdomOfTheDay() async {
    return const WisdomModel(
      id: '1',
      text:
          'وقال (عليه السلام): قُرِنَتِ الْهَيْبَةُ بِالْخَيْبَةِ، وَالْحَيَاءُ بِالْحِرْمَانِ، وَالْفُرْصَةُ تَمُرُّ مَرَّ السَّحَابِ، فَانْتَهِزُوا فُرَصَ الْخَيْرِ.',
      source: 'نهج البلاغة: الحكمة 17',
      benefit:
          'الحكمة تدعو إلى اغتنام الفرص السانحة لعمل الخير وعدم التردد أو التكاسل، فإن الهيبة الزائدة عن الحد تقود للخيبة والضياع، والحياء المانع من طلب المعالي يقود للحرمان.',
      difficultWords:
          'الهيبة: الخوف والوجل | الخيبة: الحرمان وفقدان المطلب | الحرمان: منع الإنسان مما يريد | انتهزوا: اغتنموا وبادروا.',
    );
  }
}
