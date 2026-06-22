import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/components/scholar_avatar.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_cubit.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/section_header.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // void _navigateToBookDetails(BookEntity book) {
  //   Navigator.pushNamed(context, AppRoutes.bookDetailsScreen, arguments: book);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadHomeData(),
      child: Scaffold(
        // backgroundColor: AppColorsLight.grayLight,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: HORIZONTAL,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColorsLight.gray.withAlpha(50)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColorsLight.black.withAlpha(10),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColorsLight.secondary,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "ابحث في نهج البلاغة...",
                          hintStyle: TextStyle(
                            color: AppColorsLight.gray,
                            fontSize: 13,
                            fontFamily: FONT_FAMILY_CAIRO,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          filled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Wisdom of the Day Card
              // WisdomCard(wisdom: data.wisdomOfTheDay),
              const SizedBox(height: 20),

              // Foreign Studies Section (الدراسات الأجنبية)
              SectionHeader(
                title: "الدراسات الأجنبية",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {},
              ),
              const SizedBox(height: 10),

              // SizedBox(
              //   height: 180,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: data.foreignStudies.length,
              //     itemBuilder: (context, index) {
              //       return BookItemCard(
              //         book: data.foreignStudies[index],
              //         onTap: () =>
              //             _navigateToBookDetails(data.foreignStudies[index]),
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(height: 20),

              // Articles Section (المقالات)
              SectionHeader(
                title: "المقالات",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {},
              ),
              const SizedBox(height: 10),

              // SizedBox(
              //   height: 180,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: data.articles.length,
              //     itemBuilder: (context, index) {
              //       return BookItemCard(
              //         book: data.articles[index],
              //         onTap: () => _navigateToBookDetails(data.articles[index]),
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(height: 20),

              // Scholar Commentators (أعلام الشارحين)
              SectionHeader(
                title: "أعلام الشارحين",
                fontSize: 14,
                titleColor: AppColorsLight.textPrimary,
                actionText: "المزيد",
                onActionTap: () {},
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
              const TextWidget(
                title: "أعلام نهج البلاغة",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColorsLight.textPrimary,
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
