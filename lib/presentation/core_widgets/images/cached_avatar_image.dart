import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedAvatarImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;
  final double? size;
  final double borderWidth;
  final bool showShadow;
  final Color borderColor;

  const CachedAvatarImage({
    this.imageUrl 
       ,
    required this.radius,
    this.backgroundColor,
    this.size,
    this.borderWidth = 0,
    this.showShadow = false,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ]
            : const [],
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl != null? imageUrl! :  "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
          backgroundColor: backgroundColor ?? Colors.transparent,
        ),
        placeholder: (context, url) => SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor ?? Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
      ),
    );
  }
}
