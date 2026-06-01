mixin AppImages {}

mixin AppSvg {
  // final String _svgRout = 'assets/svg';
  final String browseIcon = 'assets/svg/browse-icon.svg';
  final String favoritesIcon = 'assets/svg/favorites-icon.svg';
  final String homeIcon = 'assets/svg/home-icon.svg';
  final String searchIcon = 'assets/svg/search-icon.svg';
  final String browseSolidIcon = 'assets/svg/browse-solid-icon.svg';
  final String favoritesSolidIcon = 'assets/svg/favorites-solid-icon.svg';
  final String homeSolidIcon = 'assets/svg/home-solid-icon.svg';
  final String searchSolidIcon = 'assets/svg/search-solid-icon.svg';
  final String wisdomManuscript = 'assets/svg/wisdom-manuscript.svg';
  final String nahjAlbalaghaManuscript =
      'assets/svg/nahj-albalagha-manuscript.svg';
  final String imamAliLogo = 'assets/svg/imam-ali-logo.svg';
  final String haydaryaLibraryLogo = 'assets/svg/haydarya-library-logo.svg';
  final String commaAyat = 'assets/svg/comma-ayat.svg';
}
mixin AppJson {
  final String _jsonRout = 'assets/json';
}

class AppAssets with AppImages, AppSvg, AppJson {}
