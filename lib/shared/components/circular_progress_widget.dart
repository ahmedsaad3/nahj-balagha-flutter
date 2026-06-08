import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

class CircularProgressWidget extends StatelessWidget {
  final Color color;
  final Animation<Color?>? valueColor;
  const CircularProgressWidget({
    super.key,
    this.color = AppColorsLight.primary,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color, valueColor: valueColor),
    );
  }
}
