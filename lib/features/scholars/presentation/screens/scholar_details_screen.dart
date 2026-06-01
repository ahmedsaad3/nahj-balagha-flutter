import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/components/book_item_card.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/chip_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ScholarDetailsScreen extends StatelessWidget {
  final ScholarEntity scholar;
  const ScholarDetailsScreen({super.key, required this.scholar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiUtils.appBar(context: context, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(HORIZONTAL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  const ChipWidget(label: "أعلام"),
                  ChipWidget(
                    label: scholar.isCommentator
                        ? "شخصيات تاريخية"
                        : "أعلام الصحابة",
                  ),
                  ChipWidget(label: scholar.name),
                ],
              ),
            ),

            // Scholar Info Card (Image on left, text on right)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Specialization
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      TextWidget(
                        title: scholar.name,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColorsLight.textPrimary,
                      ),
                      TextWidget(
                        title: scholar.specialization,
                        fontSize: 18,
                        color: AppColorsLight.gray,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: scholar.image.startsWith('http')
                      ? Image.network(
                          scholar.image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 120,
                                height: 120,
                                color: AppColorsLight.grayLight,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColorsLight.primary,
                                  size: 50,
                                ),
                              ),
                        )
                      : Image.asset(
                          scholar.image,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 120,
                                height: 120,
                                color: AppColorsLight.grayLight,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColorsLight.primary,
                                  size: 50,
                                ),
                              ),
                        ),
                ),
              ],
            ),

            // Biography Paragraph
            TextWidget(
              title: scholar.bio,
              fontSize: 16,
              height: 1.8,
              color: AppColorsLight.textPrimary,
              alignment: TextAlign.justify,
            ),

            // Works section (ONLY for commentators)
            if (scholar.isCommentator && scholar.works.isNotEmpty) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  const TextWidget(
                    title: "أهم أعماله",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.textPrimary,
                  ),
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
              ),
            ],
          ],
        ),
      ),
    );
  }
}
