import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/components/book_item_card.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ScholarDetailsScreen extends StatelessWidget {
  final ScholarEntity scholar;

  const ScholarDetailsScreen({
    super.key,
    required this.scholar,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColorsLight.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const TextWidget(
            title: "مَعَارِفُ نَهْجِ الْبَلَاغَةِ",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(HORIZONTAL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Horizontal row of tags/chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChip("أعلام"),
                    const SizedBox(width: 8),
                    _buildChip(scholar.isCommentator ? "شخصيات تاريخية" : "أعلام الصحابة"),
                    const SizedBox(width: 8),
                    _buildChip(scholar.name, isLast: true),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Scholar Info Card (Image on left, text on right)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: scholar.image.startsWith('http')
                        ? Image.network(
                            scholar.image,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 120,
                              height: 120,
                              color: AppColorsLight.grayLight,
                              child: const Icon(Icons.person, color: AppColorsLight.primary, size: 50),
                            ),
                          )
                        : Image.asset(
                            scholar.image,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 120,
                              height: 120,
                              color: AppColorsLight.grayLight,
                              child: const Icon(Icons.person, color: AppColorsLight.primary, size: 50),
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  // Name and Specialization
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        TextWidget(
                          title: scholar.name,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColorsLight.textPrimary,
                        ),
                        const SizedBox(height: 8),
                        TextWidget(
                          title: scholar.specialization,
                          fontSize: 12,
                          color: AppColorsLight.gray,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Biography Paragraph
              TextWidget(
                title: scholar.bio,
                fontSize: 13,
                height: 1.8,
                color: AppColorsLight.textPrimary,
                alignment: TextAlign.justify,
              ),

              // Works section (ONLY for commentators)
              if (scholar.isCommentator && scholar.works.isNotEmpty) ...[
                const SizedBox(height: 30),
                const TextWidget(
                  title: "أهم أعماله",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColorsLight.textPrimary,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: scholar.works.length,
                    itemBuilder: (context, index) {
                      final book = scholar.works[index];
                      return BookItemCard(
                        book: book,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.bookDetailsScreen,
                            arguments: book,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isLast ? AppColorsLight.accent.withAlpha(20) : AppColorsLight.grayLight.withAlpha(40),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isLast ? AppColorsLight.accent.withAlpha(80) : AppColorsLight.gray.withAlpha(40),
          width: 1,
        ),
      ),
      child: TextWidget(
        title: label,
        fontSize: 11,
        color: isLast ? AppColorsLight.accent : AppColorsLight.gray,
        fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
