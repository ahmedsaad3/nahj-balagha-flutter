class ApiNetwork {
  static const String BASE_API_NAHJ_BALAGHA = 'http://31.220.82.155:8088/api';
  static String IMAGE({required String path}) => '$BASE_API_NAHJ_BALAGHA/$path';

  // Auth
  static const String SIGNIN_ENDPOINT = '/login';
  static const String SIGNUP_ENDPOINT = '/login';
  static const String UPDATE_PROFILE_ENDPOINT = '/login';

  // Scholars
  static const String GET_SCHOLARS = '$BASE_API_NAHJ_BALAGHA/person';
  static const String GET_SCHOLARS_TYPE = '$BASE_API_NAHJ_BALAGHA/personType';

  // Home
  static const String GET_HIKMAH_TODAY_ENDPOINT =
      '$BASE_API_NAHJ_BALAGHA/hikmah/today';

  // Books
  static const String GET_BOOKS_ENDPOINT = '$BASE_API_NAHJ_BALAGHA/book';

  // Notifications
  static const String NOTIFICATIONS_ENDPOINT =
      '$BASE_API_NAHJ_BALAGHA/notifications';
  static const String MAILBOX_ENDPOINT = '$BASE_API_NAHJ_BALAGHA/notifications';

  // FAQ
  static const String FAQS_ENDPOINT = '$BASE_API_NAHJ_BALAGHA/user';
}
