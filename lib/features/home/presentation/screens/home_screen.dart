import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/components/book_item_card.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/components/hikmah_card.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/components/scholar_avatar.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_cubit.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()..loadHomeData(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: HORIZONTAL,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              InputFieldWidget(
                hintText: "ابحث في نهج البلاغة...",
                textInputType: TextInputType.text,
                icon: Icons.search,
                imageType: ImageType.icon,
              ),
              const SizedBox(height: 16),

              BlocStateBuilderWidget<HomeCubit, HomeState, HikmahEntity>(
                stateSelector: (state) => state.hikmahState,
                dataSelector: (state) => state.hikmah!,
                loadingBuilder: (context) => const CircularProgressWidget(),
                loadedBuilder: (context, state, hikmah) =>
                    HikmahCard(hikmah: hikmah),
                errorMessageSelector: (state) => state.hikmahErrorMessage,
                buildWhen: (previous, current) =>
                    previous.hikmahState != current.hikmahState,
              ),
              const SizedBox(height: 20),

              // Articles Section (المقالات)
              SectionHeader(
                title: "الكتب",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {
                  Navigator.pushNamed(context, AppRoutes.booksScreen);
                },
              ),
              const SizedBox(height: 10),
              BlocStateBuilderWidget<HomeCubit, HomeState, List<BookEntity>>(
                stateSelector: (state) => state.booksState,
                dataSelector: (state) => state.books,
                loadingBuilder: (context) => const CircularProgressWidget(),
                loadedBuilder: (context, state, books) => SizedBox(
                  height: 120,
                  child: OverflowBox(
                    maxWidth: context.dimensions.screenWidth - 10,
                    child: CollectionViewWidget(
                      layout: CollectionLayout.list,
                      horizontal: 0,
                      vertical: 0,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.books.length,
                      itemBuilder: (context, index) => BookItemCard(
                        book: state.books[index],
                        onTap: () => {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.bookDetailsScreen,
                            arguments: state.books[index],
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                errorMessageSelector: (state) => state.scholarErrorMessage,
                buildWhen: (previous, current) =>
                    previous.scholarsState != current.scholarsState,
              ),

              const SizedBox(height: 20),

              // Scholar Commentators
              SectionHeader(
                title: "أعلام الشارحين",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {
                  Navigator.pushNamed(context, AppRoutes.scholarsScreen);
                },
              ),
              const SizedBox(height: 10),
              BlocStateBuilderWidget<HomeCubit, HomeState, List<ScholarEntity>>(
                stateSelector: (state) => state.scholarsState,
                dataSelector: (state) => state.scholars,
                loadingBuilder: (context) => const CircularProgressWidget(),
                loadedBuilder: (context, state, advertisements) => SizedBox(
                  height: 120,
                  child: OverflowBox(
                    maxWidth: context.dimensions.screenWidth - 10,
                    child: CollectionViewWidget(
                      layout: CollectionLayout.list,
                      horizontal: 0,
                      vertical: 0,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.scholars.length,
                      itemBuilder: (context, index) => ScholarAvatar(
                        scholar: state.scholars[index],
                        onTap: () => {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.scholarDetailsScreen,
                            arguments: state.scholars[index],
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                errorMessageSelector: (state) => state.scholarErrorMessage,
                buildWhen: (previous, current) =>
                    previous.scholarsState != current.scholarsState,
              ),

              const SizedBox(height: 20),

              // Figures Section (أعلام نهج البلاغة)
              SectionHeader(
                title: "أعلام نهج البلاغة",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {
                  Navigator.pushNamed(context, AppRoutes.scholarsScreen);
                },
              ),
              const SizedBox(height: 10),
              BlocStateBuilderWidget<HomeCubit, HomeState, List<ScholarEntity>>(
                stateSelector: (state) => state.scholarsState,
                dataSelector: (state) => state.scholars,
                loadingBuilder: (context) => const CircularProgressWidget(),
                loadedBuilder: (context, state, advertisements) => SizedBox(
                  height: 120,
                  child: OverflowBox(
                    maxWidth: context.dimensions.screenWidth - 10,
                    child: CollectionViewWidget(
                      layout: CollectionLayout.list,
                      horizontal: 0,
                      vertical: 0,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.scholars.length,
                      itemBuilder: (context, index) => ScholarAvatar(
                        scholar: state.scholars[index],
                        onTap: () => {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.scholarDetailsScreen,
                            arguments: state.scholars[index],
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                errorMessageSelector: (state) => state.scholarErrorMessage,
                buildWhen: (previous, current) =>
                    previous.scholarsState != current.scholarsState,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
