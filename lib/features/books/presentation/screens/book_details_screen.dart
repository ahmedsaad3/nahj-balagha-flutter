import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookEntity book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorsLight.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const TextWidget(
          title: "تفاصيل الكتاب",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(HORIZONTAL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            // Centered Book Cover
            Center(
              child: Container(
                width: 150,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RADIUS),
                  boxShadow: [
                    BoxShadow(
                      color: AppColorsLight.black.withAlpha(25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(RADIUS),
                  child: book.coverImage.startsWith('http')
                      ? Image.network(
                          book.coverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColorsLight.grayLight,
                            child: const Icon(
                              Icons.book,
                              color: AppColorsLight.primary,
                              size: 80,
                            ),
                          ),
                        )
                      : Image.asset(
                          book.coverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColorsLight.grayLight,
                            child: const Icon(
                              Icons.book,
                              color: AppColorsLight.primary,
                              size: 80,
                            ),
                          ),
                        ),
                ),
              ),
            ),
    
            const SizedBox(height: 24),
    
            // Title
            TextWidget(
              title: book.title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColorsLight.textPrimary,
              alignment: TextAlign.center,
            ),
    
            const SizedBox(height: 8),
    
            // Author
            TextWidget(
              title: book.author,
              fontSize: 14,
              color: AppColorsLight.secondary,
              fontWeight: FontWeight.bold,
              alignment: TextAlign.center,
            ),
    
            const SizedBox(height: 20),
            const Divider(color: AppColorsLight.grayLight),
            const SizedBox(height: 16),
    
            // Description Heading
            const TextWidget(
              title: "نبذة عن الكتاب:",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColorsLight.primary,
            ),
    
            const SizedBox(height: 8),
    
            // Description Text
            TextWidget(
              title: book.description,
              fontSize: 13,
              height: 1.8,
              color: AppColorsLight.textPrimary,
              alignment: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
