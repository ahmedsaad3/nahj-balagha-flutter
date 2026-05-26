import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/entities/faqs.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_state.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class FAQItemWidget extends StatelessWidget {
  final FAQs faq;

  const FAQItemWidget({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<FAQsCubit, FAQsState>(
          buildWhen: (previous, current) {
            return previous.expandedFaqId != current.expandedFaqId;
          },
          builder: (context, state) {
            final isExpanded = state.expandedFaqId == faq.id;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.read<FAQsCubit>().toggleExpanded(faqId: faq.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HORIZONTAL,
                      vertical: 12,
                    ),
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: TextWidget(
                            title: faq.question,
                            fontSize: 14,
                            color: AppColorsLight.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: const Icon(
                            Icons.add,
                            color: AppColorsLight.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: child,
                        ),
                      );
                    },
                    child: isExpanded
                        ? Padding(
                            key: const ValueKey('expanded'),
                            padding: const EdgeInsets.fromLTRB(
                              HORIZONTAL,
                              0,
                              HORIZONTAL,
                              10,
                            ),
                            child: TextWidget(
                              title: faq.answer,
                              alignment: TextAlign.right,
                              fontSize: 12,
                              color: AppColorsLight.secondary,
                              height: 1.8,
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('collapsed')),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class BuildFaqsCardWidget extends StatelessWidget {
  final List<FAQs> faqs;

  const BuildFaqsCardWidget({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return CollectionViewWidget(
      itemCount: faqs.length,
      layout: CollectionLayout.list,
      horizontal: 0,
      vertical: 20,
      separatorBuilder: (_, index) => const SizedBox.shrink(),
      itemBuilder: (_, index) {
        return FAQItemWidget(faq: faqs[index]);
      },
    );
  }
}
