import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/grammar_model_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class GrammarTabView extends StatelessWidget {
  const GrammarTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<
      ContentCubit,
      ContentState,
      ContentDetailsEntity?
    >(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) => content == null || content.grammars.isEmpty,
      emptyMessage: "لا يوجد إعراب متاح",
      loadingBuilder: (context) =>
          CircularProgressWidget(),
      loadedBuilder: (context, state, content) {
        return CollectionViewWidget(
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: SoftDividerWidget(),
          ),
          itemCount: content!.grammars.length,
          itemBuilder: (context, index) {
            final grammar = content.grammars[index];
            return _GrammarItemWidget(grammar: grammar);
          },
        );
      },
    );
  }
}

class _GrammarItemWidget extends StatefulWidget {
  final GrammarEntity grammar;

  const _GrammarItemWidget({required this.grammar});

  @override
  State<_GrammarItemWidget> createState() => _GrammarItemWidgetState();
}

class _GrammarItemWidgetState extends State<_GrammarItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      title: widget.grammar.sentence,
                      fontSize: 18,
                      alignment: TextAlign.center,
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: AppColorsLight.gray,
                  ),
                ],
              ),
              const SoftDividerWidget(),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 12),
          ...widget.grammar.analysis.map(
            (wordAnalysis) => Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: FONT_FAMILY_CAIRO,
                    fontSize: 16,
                    color: AppColorsLight.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: "${wordAnalysis.word}\n",
                      style: const TextStyle(color: AppColorsLight.textPrimary),
                    ),
                    TextSpan(
                      text: wordAnalysis.analysisText,
                      style: const TextStyle(color: AppColorsLight.accent),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
