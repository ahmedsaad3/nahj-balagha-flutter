import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class VocabularyTabView extends StatelessWidget {
  const VocabularyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<
      ContentCubit,
      ContentState,
      ContentDetailsEntity?
    >(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) =>
          content == null || content.vocabularies.isEmpty,
      emptyMessage: "لا توجد مفردات متاحة",
      loadingBuilder: (context) => CircularProgressWidget(),
      loadedBuilder: (context, state, content) {
        return CollectionViewWidget(
          itemCount: content!.vocabularies.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: SoftDividerWidget(),
          ),
          itemBuilder: (context, index) {
            final vocab = content.vocabularies[index];
            return Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: vocab.word,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                Expanded(
                  child: TextWidget(
                    title: vocab.definition,
                    fontSize: 16,
                    height: 1.8,
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
