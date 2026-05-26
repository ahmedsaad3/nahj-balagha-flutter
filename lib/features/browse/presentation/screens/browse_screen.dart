import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TextWidget(title: "Browse"));
  }
}
