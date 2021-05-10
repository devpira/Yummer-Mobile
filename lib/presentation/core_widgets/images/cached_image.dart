import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double borderRadius;
  const CachedImage({
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.borderRadius = 0
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      //fit: BoxFit.cover,
      placeholder: (context, url) => const CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error_outline),
    );
  }
}
