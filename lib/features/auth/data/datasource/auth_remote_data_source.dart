import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/data/datasource/base_auth_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSource({required DioClient client}) : _client = client;

  @override
  Future<Result> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result> signin({required Map<String, dynamic> body}) async {
    final response = await _client.postRequest(
      url: ApiNetwork.SIGNIN_ENDPOINT,
      converter: (response) {
        final Map<String, dynamic> res = {
          "visitor": UserModel.fromJson(
            response["visitor"] as Map<String, dynamic>,
          ),
          "token": response["token"],
        };
        return res;
      },
      data: body,
    );
    return response;
  }

  @override
  Future<Result> signup({required SignupParams params}) async {
    final response = await _client.postFormDataRequest(
      url: ApiNetwork.SIGNUP_ENDPOINT,
      converter: (response) {
        final Map<String, dynamic> res = {
          "visitor": UserModel.fromJson(
            response["visitor"] as Map<String, dynamic>,
          ),
          "token": response["token"],
        };
        return res;
      },
      data: params.toJson(),
    );
    return response;
  }

  @override
  Future<Result> update({required UpdateUserInfoParams params}) async {
    final Map<String, dynamic> data = params.toJson();

    // if (params.image != null) {
    //   data["image"] = await MultipartFile.fromFile(
    //     params.image!.path,
    //     filename: params.image!.name,
    //   );
    // }

    final response = await _client.putFormDataRequest(
      url: ApiNetwork.UPDATE_PROFILE_ENDPOINT,
      isAuth: true,
      converter: (response) {
        final Map<String, dynamic> res = {
          "visitor": UserModel.fromJson(
            response["visitor"] as Map<String, dynamic>,
          ),
          "token": response["token"],
        };
        return res;
      },
      data: data,
    );

    return response;
  }
}
