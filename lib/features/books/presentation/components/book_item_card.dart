import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BookItemCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback onTap;

  const BookItemCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RADIUS),
      child: Container(
        width: 120,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RADIUS),
          boxShadow: [UiUtils.softShadow()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Book Cover Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(RADIUS),
                ),
                child: book.coverImage != null
                    ? (book.coverImage!.startsWith('http')
                          ? Image.network(
                              book.coverImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: AppColorsLight.grayLight,
                                    child: const Icon(
                                      Icons.book,
                                      color: AppColorsLight.primary,
                                      size: 40,
                                    ),
                                  ),
                            )
                          : Image.network(
                              'http://31.220.82.155:8088${book.coverImage}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: AppColorsLight.grayLight,
                                    child: const Icon(
                                      Icons.book,
                                      color: AppColorsLight.primary,
                                      size: 40,
                                    ),
                                  ),
                            ))
                    : Container(
                        color: AppColorsLight.grayLight,
                        child: const Icon(
                          Icons.book,
                          color: AppColorsLight.primary,
                          size: 40,
                        ),
                      ),
              ),
            ),
            // Book Info
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: book.title,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.textPrimary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  TextWidget(
                    title: book.scholarName ?? 'غير معروف',
                    fontSize: 10,
                    color: AppColorsLight.gray,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
