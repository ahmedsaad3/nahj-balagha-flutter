import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/data/model/book.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination_model.dart';

class BookRemoteDataSource implements BaseBookRemoteDataSource {
  final DioClient _client;

  BookRemoteDataSource({required DioClient client}) : _client = client;

  @override
  Future<Result> getBooks({required PaginationParams params}) async {
    return _client.getRequest(
      url: ApiNetwork.GET_BOOKS_ENDPOINT,
      isAuth: true,
      isIsolate: false,
      queryParameters: params.toJson(),
      converter: (response) {
        return PaginationModel.fromJson(
          response,
          (json) => BookModel.fromJson(json),
        );
      },
    );
  }
}
