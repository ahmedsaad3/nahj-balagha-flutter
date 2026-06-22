import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/base_home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/home_data.dart';
import 'package:nahj_balagha_flutter/features/home/domain/repository/base_home_repository.dart';

class HomeRepositoryImpl implements BaseHomeRepository {
  final BaseHomeRemoteDataSource homeRemoteDataSource;
  final BaseBookRemoteDataSource bookRemoteDataSource;

  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.bookRemoteDataSource,
  });
  @override
  Future<Result<HomeData>> getHomeData() async {
    try {
      final wisdom = await homeRemoteDataSource.getWisdomOfTheDay();

      final foreignStudiesResult = await bookRemoteDataSource
          .getForeignStudies();
      final articlesResult = await bookRemoteDataSource.getArticles();
      // final scholarsResult = await scholarRemoteDataSource.getScholars()

      final foreignStudies = foreignStudiesResult is Success
          ? (foreignStudiesResult as Success).response
          : [];

      final articles = articlesResult is Success
          ? (articlesResult as Success).response
          : [];

      // final scholars = scholarsResult is Success
      //     ? (scholarsResult as Success).response
      //     : [];

      final homeData = HomeData(
        wisdomOfTheDay: wisdom,
        foreignStudies: List.from(foreignStudies),
        articles: List.from(articles),
        // scholars: List.from(scholars),
      );

      return Success<HomeData>(response: homeData);
    } catch (e) {
      return Failure<HomeData>(code: 500);
    }
  }
}
