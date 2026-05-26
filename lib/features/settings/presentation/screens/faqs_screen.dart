import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/entities/faqs.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/components/faq_item_widget.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FAQsCubit>()..fetchFaqs(),
      child: Scaffold(
        appBar: UiUtils.appBar(
          context: context,
          centerTitle: true,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        body: BlocBuilder<FAQsCubit, FAQsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextWidget(
                        title: "الأسئلة الشائعة",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        alignment: TextAlign.center,
                        color: AppColorsLight.primary,
                      ),
                      TextWidget(
                        title: "هنا تجدون إجابات لجميع استفساراتكم حول التطبيق وكيفية استخدامه",
                        fontSize: 13,
                        alignment: TextAlign.center,
                        color: AppColorsLight.black,
                        height: 1.8,
                      ),
                      const SizedBox(height: 10),
                      InputFieldWidget(
                        hintText: "بحث في الأسئلة الشائعة",
                        textInputType: TextInputType.text,
                        // iconAsset: AppAssets().searchIcon,
                        imageType: ImageType.svg,
                        onChanged: (query) {
                          context.read<FAQsCubit>().updateSearchQuery(
                            query ?? '',
                          );
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child:
                      BlocStateBuilderWidget<FAQsCubit, FAQsState, List<FAQs>>(
                        stateSelector: (state) => state.faqsState,
                        dataSelector: (state) => state.filteredFaqs,
                        loadingBuilder: (context) => Column(),
                        loadedBuilder: (context, state, List<FAQs> faqs) =>
                            BuildFaqsCardWidget(faqs: faqs),
                        emptyMessage: "لا يوجد بيانات",
                        errorMessageSelector: (state) => state.errorMessage,
                        // buildWhen: (previous, current) =>
                        //     previous.faqsState != current.faqsState,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
