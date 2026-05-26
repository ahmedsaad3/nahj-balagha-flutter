import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextWidget(title: "search"),
    );
  }
}
