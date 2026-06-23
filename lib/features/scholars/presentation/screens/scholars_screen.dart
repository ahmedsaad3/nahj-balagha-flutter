import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/components/scholar_avatar.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_cubit.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ScholarsScreen extends StatefulWidget {
  const ScholarsScreen({super.key});

  @override
  State<ScholarsScreen> createState() => _ScholarsScreenState();
}

class _ScholarsScreenState extends State<ScholarsScreen> {
  late final ScrollController _scrollController;
  late final ScholarCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<ScholarCubit>()..fetchScholars();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: UiUtils.appBar(
          context: context,
          centerTitle: true,
          titleWidget: const TextWidget(
            title: "أعلام نهج البلاغة",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        body:
            BlocStateBuilderWidget<
              ScholarCubit,
              ScholarState,
              List<ScholarEntity>
            >(
              stateSelector: (state) => state.requestState,
              dataSelector: (state) => state.scholars,
              loadingBuilder: (context) =>
                  const Center(child: CircularProgressWidget()),
              loadedBuilder: (context, state, scholars) {
                return CollectionViewWidget(
                  layout: CollectionLayout.grid,
                  controller: _scrollController,
                  horizontal: 0,
                  itemCount: scholars.length,
                  crossAxisCount: 3,
                  mainAxisExtent: 130,
                  isLoadingMore: state.isLoadingMore,
                  shimmerWidget: const Center(child: CircularProgressWidget()),
                  itemBuilder: (context, index) {
                    final scholar = scholars[index];
                    return ScholarAvatar(
                      scholar: scholar,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.scholarDetailsScreen,
                          arguments: scholar,
                        );
                      },
                    );
                  },
                );
              },
              errorMessageSelector: (state) => state.message,
            ),
      ),
    );
  }
}
