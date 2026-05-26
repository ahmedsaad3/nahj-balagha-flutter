import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/components/book_item_card.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/Scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/components/scholar_avatar.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/components/wisdom_card.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_cubit.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';
import 'package:nahj_balagha_flutter/shared/components/section_header.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger loading of mock home data
    context.read<HomeCubit>().loadHomeData();
  }

  void _navigateToBookDetails(BookEntity book) {
    Navigator.pushNamed(context, AppRoutes.bookDetailsScreen, arguments: book);
  }

  void _navigateToScholarDetails(ScholarEntity scholar) {
    Navigator.pushNamed(
      context,
      AppRoutes.scholarDetailsScreen,
      arguments: scholar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColorsLight.grayLight,
      body: BlocBuilder<HomeCubit, HomeState>(
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

          final data = state.homeData;
          if (data == null) {
            return const Center(child: TextWidget(title: "لا توجد بيانات"));
          }

          final commentators = data.scholars
              .where((s) => s.isCommentator)
              .toList();
          final figures = data.scholars.where((s) => !s.isCommentator).toList();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
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
                      border: Border.all(
                        color: AppColorsLight.gray.withAlpha(50),
                      ),
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
                  WisdomCard(wisdom: data.wisdomOfTheDay),

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
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.foreignStudies.length,
                      itemBuilder: (context, index) {
                        return BookItemCard(
                          book: data.foreignStudies[index],
                          onTap: () => _navigateToBookDetails(
                            data.foreignStudies[index],
                          ),
                        );
                      },
                    ),
                  ),

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
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.articles.length,
                      itemBuilder: (context, index) {
                        return BookItemCard(
                          book: data.articles[index],
                          onTap: () =>
                              _navigateToBookDetails(data.articles[index]),
                        );
                      },
                    ),
                  ),

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
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: commentators.length,
                      itemBuilder: (context, index) {
                        return ScholarAvatar(
                          scholar: commentators[index],
                          onTap: () =>
                              _navigateToScholarDetails(commentators[index]),
                        );
                      },
                    ),
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
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: figures.length,
                      itemBuilder: (context, index) {
                        return ScholarAvatar(
                          scholar: figures[index],
                          onTap: () =>
                              _navigateToScholarDetails(figures[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
