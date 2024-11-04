import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/services/notification_services.dart';
import 'package:social_app/ecport_injection.dart';
import 'package:social_app/features/auth/data/models/user_models.dart';
import 'package:social_app/features/chat/data/models/message_mode.dart';
import 'package:social_app/features/chat/presentation/manager/creatChat/creat_chat_cubit.dart';
import 'package:social_app/features/chat/presentation/manager/sendMessage/send_message_cubit.dart';
import 'package:social_app/features/chat/presentation/widgets/build_appbar_chat.dart';

class Chat extends StatefulWidget {
  final UserModel userModel;
  final String user2;
  final String chatid;
  const Chat({
    super.key,
    required this.userModel,
    required this.chatid,
    required this.user2,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbarChat(
        name: widget.userModel.name,
        image: widget.userModel.photoUrl!,
      ),
      body: BlocBuilder<SendMessageCubit, SendMessageState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: context
                      .read<CreatChatCubit>()
                      .getMessages(chatId: widget.chatid),
                  builder: (context, snapshot) {
                    if (snapshot.data?.isEmpty == true) {
                      return const Center(
                        child: Text('No messages found'),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final reverseMessage = snapshot.data!.reversed.toList();
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent + 50,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          alignment: widget.userModel.userId !=
                                  reverseMessage[index].sendId
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Text(
                            reverseMessage[index].message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions),
                      ),
                      Expanded(
                        child: TextField(
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            await FirebaseFirestore.instance
                                .collection(AppStrings.userFireStoreKey)
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .update({
                              'last_message': _controller.text.trim(),
                            });
                            await FirebaseFirestore.instance
                                .collection(AppStrings.userFireStoreKey)
                                .doc(widget.user2)
                                .update({
                              'last_message': _controller.text.trim(),
                            });
                            if (context.mounted) {
                              context.read<SendMessageCubit>().sendMessage(
                                    chatId: widget.chatid,
                                    message: MessageModel(
                                      sendId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      message: _controller.text.trim(),
                                      timeSpam: DateTime.now(),
                                    ),
                                  );
                              _notificationService.showLocalNotication(
                                id: Random().nextInt(9999),
                                title: widget.userModel.name,
                                body: _controller.text.trim(),
                              );
                            }
                            _controller.clear();
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent + 50,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear,
                            );
                            _controller.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
