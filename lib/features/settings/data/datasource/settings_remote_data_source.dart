import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/settings/data/model/faqs_model.dart';

import 'base_settings_remote_data_source.dart';

class SettingsRemoteDataSource extends BaseSettingsRemoteDataSource {
  final DioClient _client;

  SettingsRemoteDataSource({required DioClient client}) : _client = client;
  @override
  Future<Result> getFAQs() async {
    final response = await _client.getRequest(
      url: ApiNetwork.FAQS_ENDPOINT,
      isIsolate: false,
      converter: (response) {
        final List<dynamic> faqs = response as List<dynamic>;
        return faqs.map((faq) => FAQsModel.fromJson(faq)).toList();
      },
    );
    return response;
  }
}
