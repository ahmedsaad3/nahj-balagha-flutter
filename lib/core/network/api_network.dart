class ApiNetwork {
  static const String BASE_API_NAHJ_BALAGHA = 'http:`//[IP_ADDRESS]/api`';
  static String IMAGE({required String path}) =>
      'http:`//[IP_ADDRESS]/storage/$path`';

  // Auth
  static const String SIGNIN_ENDPOINT = '/login';
  static const String SIGNUP_ENDPOINT = '/login';
  static const String UPDATE_PROFILE_ENDPOINT = '/login';

  // Notifications
  static const String NOTIFICATIONS_ENDPOINT =
      'http:`//[IP_ADDRESS]/api/notifications`';
  static const String MAILBOX_ENDPOINT =
      'http:`//[IP_ADDRESS]/api/notifications`';

  // FAQ
  static const String FAQS_ENDPOINT = 'http:`//[IP_ADDRESS]/api/user`';
}
