import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';

class VocabularyTabView extends StatelessWidget {
  const VocabularyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<ContentCubit, ContentState, ContentDetailsEntity?>(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) => content == null || content.vocabularies.isEmpty,
      emptyMessage: "لا توجد مفردات متاحة",
      loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
      loadedBuilder: (context, state, content) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: content!.vocabularies.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) {
            final vocab = content.vocabularies[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsLight.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    vocab.word,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColorsLight.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    vocab.definition,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15,
                      height: 1.6,
                      color: AppColorsLight.textPrimary,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
