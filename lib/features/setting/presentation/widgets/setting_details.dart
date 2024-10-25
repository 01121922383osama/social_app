import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/Routes/name_routes.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/features/app/presentation/cubit/trigger/trigger_cubit.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/features/setting/presentation/widgets/update_user_data.dart';

class SettingDetails extends StatelessWidget {
  final UserModel user;
  const SettingDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: CachedNetworkImage(
            imageUrl: user.photoUrl!,
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: imageProvider,
              );
            },
            errorWidget: (context, url, error) {
              return const CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Text(
          user.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        ListTile(
          title: Text(user.email!),
          leading: const Icon(Icons.email),
        ),
        ListTile(
          onTap: () {
            context.push(widget: UpdateUserData(user: user));
          },
          title: const Text('edit'),
          leading: const Icon(Icons.edit),
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Yes'),
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                        context.pushNamedAndRemoveUntil(
                            pageRoute: NameRoutes.auth);
                        context.read<TriggerCubit>().trigger(page: 0);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
