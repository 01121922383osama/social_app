import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/services/notification_services.dart';
import 'package:social_app/features/chat/presentation/manager/creatChat/creat_chat_cubit.dart';
import 'package:social_app/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:social_app/features/chat/presentation/manager/sendMessage/send_message_cubit.dart';
import 'package:social_app/features/home/presentation/cubit/get_all_posts/get_all_posts_cubit.dart';
import 'package:social_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/UpdateUser/update_user_setting_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/UploadeImage/ulpoade_image_cubit.dart';
import 'package:social_app/features/setting/presentation/cubit/setting_cubit.dart';

import 'config/Routes/app_routes.dart';
import 'config/Routes/name_routes.dart';
import 'features/app/presentation/cubit/trigger/trigger_cubit.dart';
import 'features/auth/presentation/cubit/Toggle/toggle.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await NotificationService().requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TriggerCubit(),
        ),
        BlocProvider(
          create: (context) => AuthObsecureCubit(),
        ),
        BlocProvider(
          create: (context) => AuthToggle(),
        ),
        BlocProvider(
          create: (context) => di.getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<SettingCubit>()..getUserData(),
        ),
        BlocProvider(
          create: (context) => di.getIt<UpdateUserSettingCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<UlpoadeImageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<GetAllPostsCubit>()..getAllPosts(),
        ),
        BlocProvider(
          create: (context) => di.getIt<ChatCubit>()..getUsers(),
        ),
        BlocProvider(
          create: (context) => di.getIt<CreatChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<SendMessageCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: NameRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onUnknownRoute: AppRoutes.onUnknownRoute,
      ),
    );
  }
}
