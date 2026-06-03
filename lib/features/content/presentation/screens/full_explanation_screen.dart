import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/breadcrumbs_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';

class FullExplanationScreen extends StatefulWidget {
  final ScholarExplanationEntity initialExplanation;
  final List<ScholarExplanationEntity> explanations;
  final bool isComparing;
  final List<String> selectedIds;

  const FullExplanationScreen({
    super.key,
    required this.initialExplanation,
    required this.explanations,
    this.isComparing = false,
    this.selectedIds = const [],
  });

  @override
  State<FullExplanationScreen> createState() => _FullExplanationScreenState();
}

class _FullExplanationScreenState extends State<FullExplanationScreen> {
  bool _isFavorite = false;
  int _topActiveIndex = 0;
  int _bottomActiveIndex = 1;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ContentCubit>();
    if (widget.isComparing) {
      cubit.setSelectedScholars(widget.selectedIds);
      cubit.setComparisonMode(true);
    } else {
      cubit.clearScholarsSelection();
      cubit.setComparisonMode(false);
    }
  }

  void _onShare() {
    UiUtils.toastMessage(
      context: context,
      message: "تم نسخ رابط الشرح للمشاركة",
      backgroundColor: const Color(0xFF1F8C64),
    );
  }

  void _onToggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    UiUtils.toastMessage(
      context: context,
      message: _isFavorite
          ? "تمت إضافة الشرح إلى المفضلة"
          : "تمت إزالة الشرح من المفضلة",
      backgroundColor: const Color(0xFF1F8C64),
    );
  }

  Widget _buildPaneTabs({
    required List<ScholarExplanationEntity> explanations,
    required int activeIndex,
    required ValueChanged<int> onSelected,
  }) {
    if (explanations.length <= 1) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(explanations.length, (index) {
            final name = explanations[index].scholarName;
            final isSelected = index == activeIndex;

            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ChoiceChip(
                label: TextWidget(
                  title: name,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? const Color(0xFFC9A257)
                      : AppColorsLight.textPrimary,
                ),
                selected: isSelected,
                selectedColor: const Color(0xFFC9A257).withOpacity(0.12),
                backgroundColor: AppColorsLight.grayLight.withOpacity(0.2),
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFFC9A257)
                      : Colors.transparent,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onSelected: (selected) {
                  if (selected) {
                    onSelected(index);
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildExplanationContent(ScholarExplanationEntity explanation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 10,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColorsLight.grayLight,
                child: const Icon(
                  Icons.person_rounded,
                  color: AppColorsLight.gray,
                  size: 20,
                ),
              ),
              Expanded(
                child: TextWidget(title: explanation.scholarName, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: TextWidget(
                title: explanation.fullText,
                fontSize: 16,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCubit, ContentState>(
      builder: (context, state) {
        final isComparingMode =
            state.isComparing && state.selectedScholars.isNotEmpty;

        List<ScholarExplanationEntity> displayedExplanations;
        if (isComparingMode) {
          displayedExplanations = widget.explanations
              .where((exp) => state.selectedScholars.contains(exp.id))
              .toList();
        } else {
          displayedExplanations = [widget.initialExplanation];
        }

        if (_topActiveIndex >= displayedExplanations.length) {
          _topActiveIndex = 0;
        }
        if (_bottomActiveIndex >= displayedExplanations.length) {
          _bottomActiveIndex = displayedExplanations.length > 1 ? 1 : 0;
        }

        return Scaffold(
          appBar: UiUtils.appBar(context: context),
          body: Column(
            children: [
              BreadcrumbsWidget(
                trail: [
                  const BrowseNode(id: 'sermon_79', title: 'الخطبة 79'),
                  if (isComparingMode)
                    const BrowseNode(id: 'compare', title: 'مقارنة الشرح')
                  else
                    const BrowseNode(
                      id: 'explanation',
                      title: 'الشرح التفصيلي',
                    ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    // Top Pane
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (isComparingMode)
                            _buildPaneTabs(
                              explanations: displayedExplanations,
                              activeIndex: _topActiveIndex,
                              onSelected: (index) {
                                setState(() {
                                  _topActiveIndex = index;
                                });
                              },
                            ),
                          Expanded(
                            child: _buildExplanationContent(
                              displayedExplanations[_topActiveIndex],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Horizontal Divider & Bottom Pane
                    if (isComparingMode) ...[
                      // Container(height: 2, color: const Color(0xFFDEB14E)),
                      SoftDividerWidget(
                        color: AppColorsLight.secondary,
                        enableGradient: false,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPaneTabs(
                              explanations: displayedExplanations,
                              activeIndex: _bottomActiveIndex,
                              onSelected: (index) {
                                setState(() {
                                  _bottomActiveIndex = index;
                                });
                              },
                            ),
                            Expanded(
                              child: _buildExplanationContent(
                                displayedExplanations[_bottomActiveIndex],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isComparingMode
              ? null
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [UiUtils.softShadow()],
                  ),
                  padding: EdgeInsets.zero,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBottomBarButton(
                          icon: Icons.view_week_outlined,
                          label: "مقارنة مع شرح آخر",
                          onTap: () => Navigator.pop(context),
                        ),
                        _buildBottomBarButton(
                          icon: _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          label: "اضافة للمفضلة",
                          onTap: _onToggleFavorite,
                        ),
                        _buildBottomBarButton(
                          icon: Icons.share_outlined,
                          label: "مشاركة",
                          onTap: _onShare,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBottomBarButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(icon, color: AppColorsLight.secondary, size: 28),
          TextWidget(
            title: label,
            color: AppColorsLight.secondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
