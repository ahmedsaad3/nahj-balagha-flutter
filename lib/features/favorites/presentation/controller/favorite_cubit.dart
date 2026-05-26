import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/controller/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState());
}
