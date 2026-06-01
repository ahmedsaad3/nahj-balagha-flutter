import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ReferenceTabView extends StatelessWidget {
  const ReferenceTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<ContentCubit, ContentState, ContentDetailsEntity?>(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) =>
          content == null || content.references.isEmpty,
      emptyMessage: "لا توجد أسانيد متاحة",
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      loadedBuilder: (context, state, content) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: content!.references.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final ref = content.references[index];
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book,
                          color: AppColorsLight.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextWidget(
                            title: ref.source,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColorsLight.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      ref.details,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        height: 1.6,
                        color: AppColorsLight.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
