import 'package:a_pos_flutter/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// [Image] with [CachedNetworkImage]
class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.errorImagePath,
    this.width,
    this.height,
    this.fit,
  });
  final String imageUrl;
  final String? errorImagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) =>
          errorImagePath == null ? Assets.icon.icLogo.image() : Image.asset(errorImagePath!),
    );
  }
}
