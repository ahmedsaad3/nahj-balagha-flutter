import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

class ProfileCard extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onEdit;

  const ProfileCard({super.key, this.imagePath, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final hasImage =
        (imagePath != null && imagePath!.isNotEmpty);

    ImageProvider? imageProvider;
    if (imagePath != null && imagePath!.isNotEmpty) {
      if (imagePath!.startsWith('http') || imagePath!.startsWith('https')) {
        imageProvider = NetworkImage(imagePath!);
      } else {
        imageProvider = AssetImage(imagePath!);
      }
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColorsLight.secondary,
          backgroundImage: imageProvider,
          child: !hasImage
              ? const Icon(Icons.person, size: 60, color: AppColorsLight.white)
              : null,
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(RADIUS),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColorsLight.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                size: 16,
                color: AppColorsLight.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
