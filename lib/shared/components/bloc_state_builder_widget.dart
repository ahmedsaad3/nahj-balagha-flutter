import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/shared/components/default_error_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/empty_widget.dart';

class BlocStateBuilderWidget<C extends StateStreamableSource<S>, S, T>
    extends StatelessWidget {
  /// Selector to extract the RequestState from the state
  final RequestState Function(S state) stateSelector;

  /// Selector to extract the data from the state
  final T Function(S state) dataSelector;

  /// Builder for the loading state
  final Widget Function(BuildContext context) loadingBuilder;

  /// Builder for the loaded state with data
  final Widget Function(BuildContext context, S state, T data) loadedBuilder;

  /// Optional: Builder for error state. If not provided, uses default error widget
  final Widget Function(BuildContext context, String errorMessage)?
  errorBuilder;

  /// Optional: Selector to extract error message from state
  final String Function(S state)? errorMessageSelector;

  /// Optional: Message to display when data is empty
  final String? emptyMessage;

  /// Optional: Custom widget to display when data is empty
  final Widget Function(BuildContext context)? emptyBuilder;

  /// Optional: Function to check if data is empty
  /// Default checks: null, empty string, empty list, empty map
  final bool Function(T data)? isEmptyChecker;

  /// Optional: Custom buildWhen condition
  final bool Function(S previous, S current)? buildWhen;

  const BlocStateBuilderWidget({
    super.key,
    required this.stateSelector,
    required this.dataSelector,
    required this.loadingBuilder,
    required this.loadedBuilder,
    this.errorBuilder,
    this.errorMessageSelector,
    this.emptyMessage,
    this.emptyBuilder,
    this.isEmptyChecker,
    this.buildWhen,
  });

  bool _isDataEmpty(T data) {
    if (isEmptyChecker != null) {
      return isEmptyChecker!(data);
    }

    // Default empty checks
    if (data == null) return true;
    if (data is String) return data.isEmpty;
    if (data is List) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is Set) return data.isEmpty;

    return false;
  }

  Widget _buildDefaultErrorWidget(BuildContext context, String errorMessage) {
    return DefaultErrorWidget(message: errorMessage);
  }

  Widget _buildDefaultEmptyWidget(BuildContext context) {
    return EmptyWidget(title: emptyMessage ?? "لا يوجد بيانات");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      buildWhen: buildWhen,
      builder: (context, state) {
        final requestState = stateSelector(state);

        // Loading state
        if (requestState == RequestState.loading) {
          return loadingBuilder(context);
        }

        // Loaded state
        if (requestState == RequestState.loaded) {
          final T data = dataSelector(state);

          // Check if data is empty
          if (_isDataEmpty(data)) {
            if (emptyBuilder != null) {
              return emptyBuilder!(context);
            }
            return _buildDefaultEmptyWidget(context);
          }

          return loadedBuilder(context, state, data);
        }

        // Error state
        if (requestState == RequestState.error) {
          final errorMessage = errorMessageSelector?.call(state) ?? '';

          if (errorBuilder != null) {
            return errorBuilder!(context, errorMessage);
          }

          return _buildDefaultErrorWidget(context, errorMessage);
        }

        // Default fallback
        return const SizedBox.shrink();
      },
    );
  }
}
