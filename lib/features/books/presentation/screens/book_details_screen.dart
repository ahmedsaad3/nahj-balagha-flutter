import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookEntity book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiUtils.appBar(context: context, centerTitle: true),

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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
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
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              alignment: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Author
            TextWidget(
              title: book.author,
              fontSize: 16,
              alignment: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Description Heading
            const TextWidget(
              title: "التفاصيل",
              fontSize: 16,
              color: AppColorsLight.accent,
            ),

            const SizedBox(height: 8),

            // Description Text
            TextWidget(
              title: book.description,
              fontSize: 16,
              height: 1.8,
              color: AppColorsLight.textPrimary,
              alignment: TextAlign.justify,
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
          child: ElevatedButtonWidget(
            backgroundColor: AppColorsLight.primary,
            onPressed: () {},
            title: "تحميل الكتاب",
          ),
        ),
      ),
    );
  }
}
