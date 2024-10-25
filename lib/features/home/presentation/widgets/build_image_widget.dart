import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/extension/navgator.dart';

class BuildImageWidget extends StatelessWidget {
  final String image;
  const BuildImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              alignment: Alignment.center,
              width: context.width,
              height: 350,
              fit: BoxFit.cover,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(Icons.error),
          );
        },
      ),
    );
  }
}
