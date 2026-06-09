import 'dart:convert';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/services/cache_helper.dart';
import 'package:nahj_balagha_flutter/features/favorites/data/datasource/base_favorite_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/favorites/data/model/favorite_item_model.dart';

class FavoriteRemoteDataSource implements BaseFavoriteRemoteDataSource {
  // ignore: unused_field
  final DioClient _client;
  static const String _favoritesKey = 'cached_favorites_key';

  FavoriteRemoteDataSource({required DioClient client}) : _client = client;

  static final List<FavoriteItemModel> _initialMockData = [
    // الخطب (6 items)
    const FavoriteItemModel(
      id: 's1',
      title: 'الخطبة ١: في أول الخلق والعرش',
      description: 'الْحَمْدُ للهِ الَّذِي لاَ يَبْلُغُ مِدْحَتَهُ الْقَائِلُونَ، وَلاَ يُحْصِي نَعْمَاءَهُ الْعَادُّونَ، وَلاَ يُؤَدِّي حَقَّهُ الْمُجْتَهِدُونَ...',
      category: 'الخطب',
      url: 'sermon_1',
      hasAudio: true,
    ),
    const FavoriteItemModel(
      id: 's2',
      title: 'الخطبة ٣: الشقشقية الشهيرة',
      description: 'أَمَا وَاللهِ لَقَدْ تَقَمَّصَهَا فُلاَنٌ، وَإِنَّهُ لَيَعْلَمُ أَنَّ مَحَلِّي مِنْهَا مَحَلُّ الْقُطْبِ مِنَ الرَّحَى...',
      category: 'الخطب',
      url: 'sermon_3',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 's3',
      title: 'الخطبة ١٠٥: في صفة النبي وعظمة الإسلام',
      description: 'حَتَّى أَفْضَتْ كَرَامَةُ اللهِ سُبْحَانَهُ إِلَى مُحَمَّدٍ (صلى الله عليه وآله)، فَأَخْرَجَهُ مِنْ أَفْضَلِ الْمَعَادِنِ مَنْبِتاً...',
      category: 'الخطب',
      url: 'sermon_105',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 's4',
      title: 'الخطبة ١٩٣: في صفات المتقين (خطبة همام)',
      description: 'إِنَّ اللهَ سُبْحَانَهُ وَتَعَالَى خَلَقَ الْخَلْقَ حِينَ خَلَقَهُمْ غَنِيّاً عَنْ طَاعَتِهِمْ، آمِناً مِنْ مَعْصِيَتِهِمْ...',
      category: 'الخطب',
      url: 'sermon_193',
      hasAudio: true,
    ),
    const FavoriteItemModel(
      id: 's5',
      title: 'الخطبة ٢: بعد انصرافه من صفين',
      description: 'أَحْمَدُهُ اسْتِتْمَاماً لِنِعْمَتِهِ، وَاسْتِسْلاَماً لِعِزَّتِهِ، وَاصْتِعْصَاماً مِنْ مَعْصِيَتِهِ...',
      category: 'الخطب',
      url: 'sermon_2',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 's6',
      title: 'الخطبة ٤: في مناشدته لأصحابه',
      description: 'بِنَا اهْتَدَيْتُمْ فِي الظَّلْمَاءِ، وَتَسَنَّمْتُمْ عُلْيَا الْعَلْيَاءِ، وَبِنَا انْفَجَرْتُمْ عَنِ السِّرَارِ...',
      category: 'الخطب',
      url: 'sermon_4',
      hasAudio: false,
    ),

    // الرسائل (1 item)
    const FavoriteItemModel(
      id: 'l1',
      title: 'الرسالة ٥٣: عهد الإمام لمالك الأشتر النخعي لما ولاه مصر',
      description: 'هَذَا مَا أَمَرَ بِهِ عَبْدُ اللهِ عَلِيٌّ أَمِيرُ الْمُؤْمِنِينَ، مَالِكَ بْنَ الْحَارِثِ الأَشْتَرَ فِي عَهْدِهِ إِلَيْهِ...',
      category: 'الرسائل',
      url: 'letter_53',
      hasAudio: false,
    ),

    // المفردات (5 items)
    const FavoriteItemModel(
      id: 'd1',
      title: 'معنى لغة: ابن اللبون في كلام العرب',
      description: 'ابن اللبون: هو ولد الناقة إذا استكمل السنة الثانية ودخل في السنة الثالثة، وسُمّي بذلك لأن أمه وضعت غيره فصار لها لبن...',
      category: 'المفردات',
      url: 'vocab_1',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 'd2',
      title: 'معنى لغة: تقمصها والاستعارة اللفظية',
      description: 'تقمصها: مأخوذ من القميص، أي لبسها وجعلها لنفسه كالقميص. واستخدمها الإمام علي (عليه السلام) كناية عن الاستيلاء على الخلافة...',
      category: 'المفردات',
      url: 'vocab_2',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 'd3',
      title: 'معنى لغة: الغسق والليل البهيم',
      description: 'الغسق: اشتداد ظلمة الليل وسقوط الضوء، والبهيم الأسود المظلم الممتد...',
      category: 'المفردات',
      url: 'vocab_3',
      hasAudio: false,
    ),
    const FavoriteItemModel(
      id: 'd4',
      title: 'معنى لغة: الكشح والإعراض',
      description: 'الكشح: ما بين الخاصرة إلى الضلع الخلفي، وطويت كشحاً أي أعرضت عنها ونأيت بجانبي...',
      category: 'المفردات',
      url: 'vocab_4',
      hasAudio: true,
    ),
    const FavoriteItemModel(
      id: 'd5',
      title: 'معنى لغة: الزبد الرابي',
      description: 'الزبد الرابي: الرغوة المرتفعة الطافية فوق السيل إذا جرى بقوة وعنف...',
      category: 'المفردات',
      url: 'vocab_5',
      hasAudio: false,
    ),
  ];

  @override
  Future<List<FavoriteItemModel>> getFavorites() async {
    final String? cachedData = CacheHelper.getString(key: _favoritesKey);
    if (cachedData == null) {
      // Initialize with mock data
      await _saveToCache(_initialMockData);
      return _initialMockData;
    }
    
    try {
      final List<dynamic> decodedList = jsonDecode(cachedData) as List<dynamic>;
      return decodedList
          .map((item) => FavoriteItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If parsing fails, fall back to empty or mock
      return _initialMockData;
    }
  }

  @override
  Future<void> addFavorite(FavoriteItemModel item) async {
    final List<FavoriteItemModel> current = await getFavorites();
    // Prevent duplicate entries
    if (current.any((element) => element.id == item.id)) {
      return;
    }
    current.add(item);
    await _saveToCache(current);
  }

  @override
  Future<void> removeFavorite(String id) async {
    final List<FavoriteItemModel> current = await getFavorites();
    current.removeWhere((element) => element.id == id);
    await _saveToCache(current);
  }

  Future<void> _saveToCache(List<FavoriteItemModel> list) async {
    final String encoded = jsonEncode(list.map((e) => e.toJson()).toList());
    await CacheHelper.setString(key: _favoritesKey, value: encoded);
  }
}
