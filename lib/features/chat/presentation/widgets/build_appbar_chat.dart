import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/extension/navgator.dart';

class BuildAppbarChat extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String image;
  const BuildAppbarChat({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: context.width * 0.25,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                );
              },
              errorWidget: (context, url, error) {
                return const CircleAvatar(
                  child: Icon(Icons.error),
                );
              },
            ),
          ),
        ],
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            'online',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
