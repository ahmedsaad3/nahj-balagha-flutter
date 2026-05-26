import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/data/model/book.dart';

class BookRemoteDataSource implements BaseBookRemoteDataSource {
  final DioClient _client;

  BookRemoteDataSource({required DioClient client}) : _client = client;

  @override
  Future<Result<List<BookModel>>> getForeignStudies() async {
    return Success(
      response: const [
        BookModel(
          id: 'fs1',
          title: 'نهج البلاغة في الفكر الغربي',
          author: 'د. جون وودز',
          coverImage:
              'https://images.unsplash.com/photo-1544947950-fa07a98d237f?q=80&w=200',
          description:
              'دراسة تحليلية لأثر نصوص نهج البلاغة في الدراسات الاستشراقية والفكر الغربي الحديث.',
        ),
        BookModel(
          id: 'fs2',
          title: 'العدالة الإنسانية عند علي بن أبي طالب',
          author: 'روبرت بولت',
          coverImage:
              'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=200',
          description:
              'بحث أجنبي يتناول نظرية العدالة والحكم الرشيد من خلال عهد أمير المؤمنين لمالك الأشتر.',
        ),
      ],
    );
  }

  @override
  Future<Result<List<BookModel>>> getArticles() async {
    return Success(
      response: const [
        BookModel(
          id: 'a1',
          title: 'البلاغة المعمارية في كلام الإمام علي',
          author: 'أ.د. أحمد حسن',
          coverImage:
              'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=200',
          description:
              'مقال يتناول البنية الفنية والجمالية للخطب الواردة في كتاب نهج البلاغة.',
        ),
        BookModel(
          id: 'a2',
          title: 'منهج الإصلاح الاجتماعي في خطب النهج',
          author: 'د. علي الموسوي',
          coverImage:
              'https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?q=80&w=200',
          description:
              'دراسة مقالية حول آليات التغيير الاجتماعي ومعالجة الفساد من المنظور العلوي الشريف.',
        ),
      ],
    );
  }
}
