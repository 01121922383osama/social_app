import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildHeaderofPost extends StatelessWidget {
  final String name;
  final String imageProfile;
  final String dateTime;
  const BuildHeaderofPost({
    super.key,
    required this.name,
    required this.imageProfile,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              child: CachedNetworkImage(
                imageUrl: imageProfile,
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  );
                },
                errorWidget: (context, url, error) {
                  return const CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              // backgroundImage: NetworkImage(
              //   imageProfile,
              // ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$dateTime .⌛',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.ellipsisVertical,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
