import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';

class GrammarTabView extends StatelessWidget {
  const GrammarTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocStateBuilderWidget<ContentCubit, ContentState, ContentDetailsEntity?>(
      stateSelector: (state) => state.requestState,
      dataSelector: (state) => state.contentDetails,
      isEmptyChecker: (content) => content == null || content.grammars.isEmpty,
      emptyMessage: "لا يوجد إعراب متاح",
      loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
      loadedBuilder: (context, state, content) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: content!.grammars.length,
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final grammar = content.grammars[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColorsLight.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    grammar.sentence,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColorsLight.primaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                ...grammar.analysis.map((wordAnalysis) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontFamily: 'Cairo', fontSize: 15, color: AppColorsLight.textPrimary),
                          children: [
                            TextSpan(
                              text: "${wordAnalysis.word}: ",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColorsLight.accent),
                            ),
                            TextSpan(text: wordAnalysis.analysisText),
                          ],
                        ),
                      ),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
