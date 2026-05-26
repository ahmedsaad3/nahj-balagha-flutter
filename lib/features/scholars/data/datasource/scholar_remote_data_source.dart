import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/data/model/book.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/model/scholar.dart';

import 'base_scholar_remote_data_source.dart';

class ScholarRemoteDataSource implements BaseScholarRemoteDataSource {
  final DioClient _client;

  ScholarRemoteDataSource({required DioClient client}) : _client = client;
  @override
  Future<Result<List<ScholarModel>>> getScholars() async {
    return Success(
      response: [
        ScholarModel(
          id: 's1',
          name: 'الخوئي',
          specialization: 'مرجع ديني ومفسر ومحقق',
          bio:
              'السيد أبو القاسم الخوئي (رحمه الله)، كان من أبرز علماء الحوزة العلمية في النجف الأشرف، وله العديد من الشروحات والمصنفات في الفقه والأصول والتفسير، ويعد أستاذ الفقهاء والمجتهدين في عصره.',
          image:
              'https://i.ibb.co/3TL51zB/khoei.png', // A public placeholder or direct image
          isCommentator: true,
          works: [
            BookModel(
              id: 'sb1_1',
              title: 'البيان في تفسير القرآن',
              author: 'الخوئي',
              coverImage:
                  'https://archive.org/services/img/al-bayan-fi-tafsir-al-quran',
              description:
                  'كتاب تفسيري قيم ومقدمة أصولية هامة في علوم القرآن ومباحث التفسير.',
            ),
          ],
        ),
        ScholarModel(
          id: 's2',
          name: 'محمد تقي جعفري',
          specialization: 'فيلسوف ومفكر إسلامي',
          bio:
              'العلامة الشيخ محمد تقي جعفري (رحمه الله)، فيلسوف ومفكر ومحقق كبير، اشتهر بشرحه التفصيلي لنهج البلاغة وديوان مثنوي معنوي، وتميز برؤيته الفلسفية المقارنة بين الفكر الإسلامي والفلسفة الغربية.',
          image: 'https://i.ibb.co/f49bV24/jaafari.jpg',
          isCommentator: true,
          works: [
            BookModel(
              id: 'sb2_1',
              title: 'ترجمة وشرح نهج البلاغة',
              author: 'محمد تقي جعفري',
              coverImage: 'https://archive.org/services/img/sharh-nahj-jaafari',
              description:
                  'موسوعة شرح نهج البلاغة في عدة مجلدات تتناول الجوانب الفلسفية والكونية والإنسانية في كلام الإمام علي عليه السلام.',
            ),
          ],
        ),
        ScholarModel(
          id: 's3',
          name: 'محمد جواد مغنية',
          specialization: 'محقق نهج البلاغة ومفكر إسلامي',
          bio:
              'سماحة العلامة المحقق الشيخ محمد جواد مغنية رحمه الله هو الشيخ محمد جواد مغنية ، ابن الشيخ محمود مغنية. ولد عام 1322هـ ، بقرية طير دبا قضاء صور / لبنان درس عند شيوخ قريته، و في عام 1343هـ ، سافر إلى النجف الأشرف لإكمال دراسته الدينية العالية. تتلمذ على يد أكابر العلماء حتى اصبح علماً من أعلام الدين و رمزاً كبيراً من حيث العطاء و الاجتهاد و العلم و الاخلاق. هو مفكر اسلامي كبير و علامة جليل و كاتب و مؤلف قدير قلّ نظيره له أسفار علمية في البلاد الإسلامية ، و له مناظرات قيمة مع علماء المذاهب الإسلامية و محاولات تقريبية بين المذاهب الإسلامية.',
          image: 'https://i.ibb.co/Wc6K8Wz/mughniyah.jpg',
          isCommentator: true,
          works: [
            BookModel(
              id: 'sb3_1',
              title: 'في ظلال نهج البلاغة',
              author: 'محمد جواد مغنية',
              coverImage:
                  'https://archive.org/services/img/fi-zilal-nahj-al-balagha',
              description:
                  'شرح مبسط وميسر لخطب ورسائل وحكم نهج البلاغة، يركز على الجوانب الاجتماعية والعملية ومخاطبة جيل الشباب.',
            ),
          ],
        ),
        ScholarModel(
          id: 's4',
          name: 'ابن أبي الحديد',
          specialization: 'مؤرخ وشارح نهج البلاغة',
          bio:
              'عز الدين عبد الحميد بن هبة الله الكاتب المعروف بابن أبي الحديد المعتزلي، أديب ومؤرخ وشاعر، اشتهر بشرحه الضخم لكتاب نهج البلاغة الذي يعد مصدراً تاريخياً وأدبياً نادراً.',
          image: 'https://i.ibb.co/3TL51zB/khoei.png', // fallback
          isCommentator: true,
          works: [
            BookModel(
              id: 'sb4_1',
              title: 'شرح نهج البلاغة لأبي الحديد',
              author: 'ابن أبي الحديد',
              coverImage:
                  'https://archive.org/services/img/sharh-nahj-al-hadid',
              description:
                  'كتاب شرح موسع يتحدث فيه عن التاريخ الإسلامي والتفاصيل اللغوية والأدبية لنهج البلاغة.',
            ),
          ],
        ),
        ScholarModel(
          id: 's5',
          name: 'سلمان الفارسي',
          specialization:
              'صحابي جليل من خيرة أصحاب رسول الله صلى الله عليه وآله وأمير المؤمنين عليه السلام',
          bio:
              'سلمان الفارسي، الملقب بسلمان المحمدي، صحابي جليل وواحد من أقرب أصحاب النبي والأمام علي عليهما السلام. تميز بحكمته وعلمه الغزير وسيرته العطرة وزهده في الدنيا، وكان والياً على المدائن وعاش عمراً طويلاً في خدمة الحق ورسالته.',
          image: 'https://i.ibb.co/3TL51zB/khoei.png', // fallback
          isCommentator: false,
          works: [], // أعلام نهج البلاغة لا أعمال لهم حسب الشرط
        ),
      ],
    );
  }
}
