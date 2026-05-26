import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState());
}
