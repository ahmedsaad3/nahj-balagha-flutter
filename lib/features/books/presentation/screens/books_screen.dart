import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_cubit.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_state.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/components/book_item_card.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late final ScrollController _scrollController;
  late final BookCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<BookCubit>()..getBooks();
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
        appBar: UiUtils.appBar(context: context, centerTitle: true),
        body: BlocStateBuilderWidget<BookCubit, BookState, List<BookEntity>>(
          stateSelector: (state) => state.requestState,
          dataSelector: (state) => state.data,
          loadingBuilder: (context) =>
              const Center(child: CircularProgressWidget()),
          loadedBuilder: (context, state, books) {
            return CollectionViewWidget(
              layout: CollectionLayout.grid,
              controller: _scrollController,
              itemCount: books.length,
              crossAxisCount: 3,
              isLoadingMore: state.isLoadingMore,
              shimmerWidget: const Center(child: CircularProgressWidget()),
              itemBuilder: (context, index) {
                final book = books[index];
                return BookItemCard(
                  book: book,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.bookDetailsScreen,
                      arguments: book,
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
