import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/home_mock_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/home_data.dart';
import 'package:nahj_balagha_flutter/features/home/domain/repository/base_home_repository.dart';

class HomeRepositoryImpl implements BaseHomeRepository {
  final HomeMockDataSource homeMockDataSource;

  HomeRepositoryImpl({required this.homeMockDataSource});

  @override
  Future<Result<HomeData>> getHomeData() async {
    try {
      final wisdom = await homeMockDataSource.getWisdomOfTheDay();
      final books = await homeMockDataSource.getBooks();
      final foreignStudies = await homeMockDataSource.getForeignStudies();
      final articles = await homeMockDataSource.getArticles();
      final scholars = await homeMockDataSource.getScholars();

      final homeData = HomeData(
        wisdomOfTheDay: wisdom,
        books: books,
        foreignStudies: foreignStudies,
        articles: articles,
        scholars: scholars,
      );

      return Success<HomeData>(response: homeData);
    } catch (e) {
      return Failure<HomeData>(code: 500);
    }
  }
}
