import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ReferenceTabView extends StatelessWidget {
  const ReferenceTabView({super.key});

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
          content == null || content.references.isEmpty,
      emptyMessage: "لا توجد أسانيد متاحة",
      loadingBuilder: (context) => CircularProgressWidget(),
      loadedBuilder: (context, state, content) {
        return CollectionViewWidget(
          itemCount: content!.references.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: SoftDividerWidget(),
          ),
          itemBuilder: (context, index) {
            final ref = content.references[index];
            return Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        title: ref.source,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                TextWidget(
                  title: ref.details,
                  fontSize: 16,
                  height: 1.8,
                  color: AppColorsLight.textPrimary,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
