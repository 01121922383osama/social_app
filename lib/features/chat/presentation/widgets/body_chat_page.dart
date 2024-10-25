import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/features/chat/presentation/manager/creatChat/creat_chat_cubit.dart';
import 'package:social_app/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/pages/chat.dart';

class BodyChatPage extends StatelessWidget {
  const BodyChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is ChatSuccess) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  onTap: () {
                    context
                        .read<CreatChatCubit>()
                        .createChat(
                          userId1: FirebaseAuth.instance.currentUser!.uid,
                          userId2: user.userId,
                        )
                        .then((chatId) {
                      if (context.mounted) {
                        context.push(
                            widget: Chat(
                          chatid: chatId,
                          userModel: user,
                        ));
                      }
                    });
                  },
                  dense: true,
                  leading: CachedNetworkImage(
                    imageUrl: user.photoUrl!,
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
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text('Last message'),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
