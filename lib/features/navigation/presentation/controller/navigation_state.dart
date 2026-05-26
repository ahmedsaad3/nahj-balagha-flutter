import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class NavigationState extends Equatable {
  final int selectedIndex;
  final List<Widget> screens;
  final Map<int, Widget> replacedScreens;

  const NavigationState({
    this.selectedIndex = 0,
    this.screens = const <Widget>[],
    this.replacedScreens = const <int, Widget>{},
  });

  NavigationState copyWith({
    int? selectedIndex,
    List<Widget>? screens,
    Map<int, Widget>? replacedScreens,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      screens: screens ?? this.screens,
      replacedScreens: replacedScreens ?? this.replacedScreens,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, screens, replacedScreens];
}
