import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class FavoriteCard extends StatefulWidget {
  final FavoriteItem item;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onTap,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleRemove() {
    if (_isRemoving) return;
    setState(() {
      _isRemoving = true;
    });
    _controller.forward().then((_) {
      widget.onRemove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Visibility(
          visible: _sizeAnimation.value > 0.01,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Align(
              heightFactor: _sizeAnimation.value,
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColorsLight.white,
          borderRadius: BorderRadius.circular(RADIUS),
          boxShadow: [UiUtils.softShadow()],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(RADIUS),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.item.hasAudio) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColorsLight.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.volume_up_rounded,
                        color: AppColorsLight.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        TextWidget(
                          title: widget.item.title,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: FONT_FAMILY_CAIRO,
                        ),
                        TextWidget(
                          title: widget.item.description,
                          fontSize: 12,
                          color: AppColorsLight.gray,
                          maxLines: 2,
                          height: 1.8,
                          fontFamily: FONT_FAMILY_CAIRO,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Action: Star icon to remove from favorites
                  IconButton(
                    icon: const Icon(
                      Icons.star_rounded,
                      color: AppColorsLight.secondary, // Gold color
                      size: 28,
                    ),
                    onPressed: _handleRemove,
                    tooltip: 'إزالة من المفضلة',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
