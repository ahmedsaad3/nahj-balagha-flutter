import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextWidget(title: "favorite"),
    );
  }
}
