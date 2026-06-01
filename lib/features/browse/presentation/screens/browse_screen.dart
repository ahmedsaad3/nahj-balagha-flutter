import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/components/category_section_widget.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/controller/browse_cubit.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/controller/browse_state.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void initState() {
    super.initState();
    // Load fresh browsing category data
    context.read<BrowseCubit>().loadBrowseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BrowseCubit, BrowseState>(
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

          final categories = state.categories;
          if (categories.isEmpty) {
            return const Center(
              child: TextWidget(title: "لا توجد تصنيفات", fontSize: 16),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategorySectionWidget(category: category);
            },
          );
        },
      ),
    );
  }
}
