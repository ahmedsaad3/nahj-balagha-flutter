// import 'package:flutter/material.dart';
// import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
// import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
// import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
// import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
// import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';

// class ExplanationTabView extends StatelessWidget {
//   const ExplanationTabView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocStateBuilderWidget<ContentCubit, ContentState, ContentDetailsEntity?>(
//       stateSelector: (state) => state.requestState,
//       dataSelector: (state) => state.contentDetails,
//       isEmptyChecker: (content) => content == null || content.explanations.isEmpty,
//       emptyMessage: "لا توجد شروحات متاحة",
//       loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
//       loadedBuilder: (context, state, content) {
//         return ListView.separated(
//           padding: const EdgeInsets.all(20),
//           itemCount: content!.explanations.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 16),
//           itemBuilder: (context, index) {
//             final explanation = content.explanations[index];
//             return Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ExpansionTile(
//                 title: Text(
//                   explanation.scholarName,
//                   style: const TextStyle(
//                     fontFamily: 'Cairo',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: AppColorsLight.primary,
//                   ),
//                 ),
//                 subtitle: Text(
//                   explanation.excerpt,
//                   style: const TextStyle(
//                     fontFamily: 'Cairo',
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 childrenPadding: const EdgeInsets.only(
//                   left: 16,
//                   right: 16,
//                   bottom: 16,
//                 ),
//                 children: [
//                   Text(
//                     explanation.fullText,
//                     style: const TextStyle(
//                       fontFamily: 'Cairo',
//                       fontSize: 15,
//                       height: 1.8,
//                       color: AppColorsLight.textPrimary,
//                     ),
//                     textAlign: TextAlign.justify,
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/content_details_entity.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';

// New defined colors to match the design.
const Color goldBarColor = Color(0xFFE2C281);
const Color goldTextColor = Color(0xFFC9A257);
const Color avatarIconColor = Color(0xFF8194A5);

class ExplanationTabView extends StatefulWidget {
  const ExplanationTabView({super.key});

  @override
  State<ExplanationTabView> createState() => _ExplanationTabViewState();
}

class _ExplanationTabViewState extends State<ExplanationTabView> {
  // Set to store the names of scholars whose explanations are visible
  final Set<String> _visibleScholars = {};
  // Boolean state variable to manage showing full text for all cards
  bool _showAllExplanationsFullText = false;

  // Track global state. Useful if we want the full-text state to be global.
  // Not used directly in filtering but for managing text length within cards.
  @override
  void initState() {
    super.initState();
    // Initially, no specific global state for full text is set.
  }

  // Populate visible scholars from the list, making all visible by default
  void _initializeVisibleScholars(List<ScholarExplanationEntity> explanations) {
    if (_visibleScholars.isEmpty && explanations.isNotEmpty) {
      _visibleScholars.addAll(explanations.map((e) => e.scholarName).toSet());
    }
  }

  // Function to toggle the visibility of a scholar's explanation
  void _toggleScholarVisibility(String scholarName, bool isVisible) {
    setState(() {
      if (isVisible) {
        _visibleScholars.add(scholarName);
      } else {
        _visibleScholars.remove(scholarName);
      }
    });
  }

  // Toggle global show all explanations full text
  void _toggleGlobalShowFullText() {
    setState(() {
      _showAllExplanationsFullText = !_showAllExplanationsFullText;
    });
  }

  // Widget to build the filter bar (all scholars)
  Widget _buildFilterBar(List<ScholarExplanationEntity> explanations) {
    final uniqueScholars = explanations
        .map((e) => e.scholarName)
        .toSet()
        .toList();
    if (uniqueScholars.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "اختر العلماء لعرض الشرح",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColorsLight.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12.0,
          runSpacing: 4.0,
          textDirection: TextDirection.rtl,
          children: uniqueScholars.map((scholar) {
            final isVisible = _visibleScholars.contains(scholar);
            return Theme(
              // Using theme to remove unwanted borders/shadows from standard chip
              data: Theme.of(context).copyWith(
                chipTheme: ChipThemeData(
                  side: isVisible
                      ? const BorderSide(color: Colors.transparent)
                      : const BorderSide(
                          color: Colors.grey,
                        ), // Non-selected state color
                ),
              ),
              child: FilterChip(
                label: Text(
                  scholar,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: AppColorsLight.textPrimary,
                  ),
                ),
                backgroundColor: AppColorsLight.white,
                selectedColor: AppColorsLight.white,
                shape: isVisible
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: AppColorsLight.secondary,
                          width: 1.0,
                        ), // Secondary for visible
                      )
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                selected: isVisible,
                onSelected: (selected) {
                  _toggleScholarVisibility(scholar, selected);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Build the entire ListView with custom cards
  Widget _buildExplanationList(List<ScholarExplanationEntity> explanations) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20,
        ), // Bottom padding for card separation from screen bottom
        itemCount: explanations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final explanation = explanations[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: IntrinsicHeight(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  // Gold vertical bar on the right
                  Container(
                    width: 8,
                    decoration: const BoxDecoration(
                      color: goldBarColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  // Main card content column
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        textDirection: TextDirection.rtl,
                        children: [
                          // Scholar name and avatar Row
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0,
                                ), // Padding between icon and name
                                child: Icon(
                                  Icons.account_circle,
                                  color: avatarIconColor,
                                  size: 28,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  explanation.scholarName,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColorsLight.textPrimary,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Explanation Text - using maxLines and ellipsis based on global state
                          Text(
                            _showAllExplanationsFullText
                                ? explanation.fullText
                                : explanation.fullText,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              height: 1.8, // Specific line height from original
                              color: AppColorsLight.textPrimary,
                            ),
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            maxLines: _showAllExplanationsFullText
                                ? null
                                : 4, // Truncate when show full text is not globally set
                            overflow: _showAllExplanationsFullText
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          // "More..." text link below text. Align to the right
                          Align(
                            alignment: Alignment
                                .centerLeft, // Right-align to match Screenshot
                            child: TextButton(
                              onPressed: _toggleGlobalShowFullText,
                              style: TextButton.styleFrom(
                                // padding: EdgeInsets.zero,
                                // minimumSize: const Size(0, 0),
                              ),
                              child: Text(
                                _showAllExplanationsFullText
                                    ? 'المزيد ...'
                                    : 'المزيد ...',
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: goldTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
        // First initialization for first load
        _initializeVisibleScholars(content!.explanations);
        // Filter explanations list based on the visible set
        final filteredExplanations = content.explanations
            .where((exp) => _visibleScholars.contains(exp.scholarName))
            .toList();

        return Column(
          children: [
            // Filter bar at the top
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildFilterBar(
                content.explanations,
              ), // Standard padding for the filter bar
            ),
            // ListView with custom cards, taking up available space
            _buildExplanationList(filteredExplanations),
          ],
        );
      },
    );
  }
}
