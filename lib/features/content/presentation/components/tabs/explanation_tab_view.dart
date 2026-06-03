import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/explanation_card.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ExplanationTabView extends StatefulWidget {
  const ExplanationTabView({super.key});

  @override
  State<ExplanationTabView> createState() => _ExplanationTabViewState();
}

class _ExplanationTabViewState extends State<ExplanationTabView> {
  bool _isSelectionMode = false;
  final Set<String> _selectedScholarIds = {};

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedScholarIds.contains(id)) {
        _selectedScholarIds.remove(id);
      } else {
        _selectedScholarIds.add(id);
      }
    });
  }

  void _resetSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedScholarIds.clear();
    });
  }

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
          content == null || content.explanations.isEmpty,
      emptyMessage: "لا توجد شروحات متاحة",
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      loadedBuilder: (context, state, content) {
        final explanations = content!.explanations;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // Header Row
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      title: _isSelectionMode
                          ? "اختر الشرح المراد مقارنته"
                          : "الشروحات المتوفرة",
                      fontSize: 16,
                    ),
                    if (!_isSelectionMode)
                      ElevatedButtonWidget(
                        onPressed: () {
                          setState(() {
                            _isSelectionMode = true;
                          });
                        },
                        title: "مقارنة الشروح",
                        width: context.dimensions.screenWidth * 0.3,
                        height: 40,
                      )
                    else
                      ElevatedButtonWidget(
                        onPressed: () {
                          setState(() {
                            _isSelectionMode = false;
                          });
                        },
                        title: "إلغاء",
                        width: context.dimensions.screenWidth * 0.3,
                        height: 40,
                        backgroundColor: AppColorsLight.red,
                      ),
                  ],
                ),
              ),

              // Explanations List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  itemCount: explanations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final explanation = explanations[index];
                    final isSelected = _selectedScholarIds.contains(
                      explanation.id,
                    );

                    return ExplanationCard(
                      explanation: explanation,
                      isSelectionMode: _isSelectionMode,
                      isSelected: isSelected,
                      onTap: () {
                        if (_isSelectionMode) {
                          _toggleSelection(explanation.id);
                        } else {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.fullExplanationScreen,
                            arguments: {
                              'initialExplanation': explanation,
                              'explanations': explanations,
                              'isComparing': false,
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              // Bottom Action Button in Selection Mode
              if (_isSelectionMode)
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, -3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedScholarIds.length >= 2
                            ? AppColorsLight.buttonPrimary
                            : AppColorsLight.grayLight,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _selectedScholarIds.length >= 2
                          ? () {
                              final selectedExps = explanations
                                  .where(
                                    (e) => _selectedScholarIds.contains(e.id),
                                  )
                                  .toList();
                              final selectedIds = selectedExps
                                  .map((e) => e.id)
                                  .toList();
                              _resetSelection();
                              Navigator.pushNamed(
                                context,
                                AppRoutes.fullExplanationScreen,
                                arguments: {
                                  'initialExplanation': selectedExps.first,
                                  'explanations': explanations,
                                  'isComparing': true,
                                  'selectedIds': selectedIds,
                                },
                              );
                            }
                          : null,
                      child: const TextWidget(
                        title: "مقارنة",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
