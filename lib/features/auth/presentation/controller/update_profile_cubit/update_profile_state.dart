import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/auth/data/models/user_model.dart';

class UpdateProfileState extends Equatable {
  final RequestState updateState;
  final String updateMessage;
  final UserModel? user;

  const UpdateProfileState({
    this.updateState = RequestState.idle,
    this.updateMessage = '',
    this.user,
  });

  @override
  List<Object?> get props => [updateState, updateMessage, user];

  UpdateProfileState copyWith({
    RequestState? updateState,
    String? updateMessage,
    UserModel? user,
  }) {
    return UpdateProfileState(
      updateState: updateState ?? this.updateState,
      updateMessage: updateMessage ?? this.updateMessage,
      user: user ?? this.user,
    );
  }
}
