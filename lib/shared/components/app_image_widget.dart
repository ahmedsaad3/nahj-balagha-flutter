import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';

class AppImageWidget extends StatelessWidget {
  final ImageType imageType;
  final String? path;
  final IconData? icon;
  final Color? color;
  final double? size;
  final double? scale;
  final double? horizontal;
  final EdgeInsets? padding;
  final BoxFit? fit;
  final int imagePathType;
  final VoidCallback? onPressed;

  const AppImageWidget({
    super.key,
    this.imageType = ImageType.svg,
    this.path,
    this.icon,
    this.color,
    this.size = 24,
    this.scale = 0.9,
    this.onPressed,
    this.padding,
    this.horizontal,
    this.fit,
    this.imagePathType = 1,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = _buildContent(context);

    if (onPressed == null) return content;

    final child = Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 10),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          borderRadius: BorderRadius.circular(RADIUS),
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: content,
            ),
          ),
        ),
      ),
    );

    return child;
  }

  Widget _buildContent(BuildContext context) {
    switch (imageType) {
      case ImageType.svg:
        return Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontal ?? 0),
          child: Transform.scale(
            scale: scale ?? 1,
            child: SvgPicture.asset(
              path!,
              height: size,
              width: size,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            ),
          ),
        );

      case ImageType.networkSvg:
        return SvgPicture.network(
          ApiNetwork.IMAGE(path: path!),
          height: size,
          width: size,
        );
      case ImageType.asset:
        return Image.asset(
          path!,
          height: size,
          width: size,
          color: color,
          scale: scale,
          fit: fit,
        );
      case ImageType.network:
        return Image.network(
          ApiNetwork.IMAGE(path: path!),
          height: size,
          width: size,
          color: color,
          fit: fit,
        );
      case ImageType.icon:
        return Icon(icon, color: color, size: size);
    }
  }
}
