import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ScholarAvatar extends StatelessWidget {
  final ScholarEntity scholar;
  final VoidCallback onTap;

  const ScholarAvatar({
    super.key,
    required this.scholar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColorsLight.black.withAlpha(20),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: scholar.image.startsWith('http')
                    ? Image.network(
                        scholar.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColorsLight.grayLight,
                          child: const Icon(
                            Icons.person_pin,
                            color: AppColorsLight.primary,
                            size: 40,
                          ),
                        ),
                      )
                    : Image.asset(
                        scholar.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColorsLight.grayLight,
                          child: const Icon(
                            Icons.person_pin,
                            color: AppColorsLight.primary,
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 75,
              child: TextWidget(
                title: scholar.name,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColorsLight.textPrimary,
                alignment: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
