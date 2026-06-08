import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/tabs/explanation_tab_view.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/tabs/grammar_tab_view.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/tabs/reference_tab_view.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/tabs/sermon_tab_view.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/components/tabs/vocabulary_tab_view.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_cubit.dart';
import 'package:nahj_balagha_flutter/features/content/presentation/controller/content_state.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/shared/components/breadcrumbs_widget.dart';

class ContentReaderScreen extends StatefulWidget {
  final String contentId;
  final List<BrowseNode> trail;

  const ContentReaderScreen({
    super.key,
    required this.contentId,
    this.trail = const [],
  });

  @override
  State<ContentReaderScreen> createState() => _ContentReaderScreenState();
}

class _ContentReaderScreenState extends State<ContentReaderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContentCubit>().loadContentDetails(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: UiUtils.appBar(context: context),
        body: BlocBuilder<ContentCubit, ContentState>(
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
      
            if (state.requestState == RequestState.error) {
              return Center(
                child: TextWidget(
                  title: state.errorMessage,
                  color: AppColorsLight.red,
                  fontSize: 16,
                ),
              );
            }
      
            final content = state.contentDetails;
            if (content == null) {
              return const Center(
                child: TextWidget(title: "المحتوى غير موجود", fontSize: 16),
              );
            }
      
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTabBar(),
                _buildBreadcrumbs(content.title),
                Expanded(
                  child: TabBarView(
                    children: const [
                      SermonTabView(),
                      ExplanationTabView(),
                      GrammarTabView(),
                      VocabularyTabView(),
                      ReferenceTabView(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: AppColorsLight.primary,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelColor: AppColorsLight.primary,
        unselectedLabelColor: Colors.white.withOpacity(0.85),
        indicator: BoxDecoration(
          color: AppColorsLight.white,
          borderRadius: BorderRadius.circular(20),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        tabs: const [
          Tab(text: "الخطبة"),
          Tab(text: "الشرح"),
          Tab(text: "الإعراب"),
          Tab(text: "المفردات"),
          Tab(text: "السند"),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(String title) {
    final fullTrail = [
      ...widget.trail,
      BrowseNode(id: widget.contentId, title: title),
    ];
    return BreadcrumbsWidget(trail: fullTrail);
  }
}
