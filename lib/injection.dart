import 'package:social_app/features/chat/domain/usecases/create_or_getchat_usecase.dart';
import 'package:social_app/features/chat/domain/usecases/get_stream_message_usecase.dart';
import 'package:social_app/features/chat/domain/usecases/sen_message_usecase.dart';
import 'package:social_app/features/chat/presentation/manager/creatChat/creat_chat_cubit.dart';
import 'package:social_app/features/chat/presentation/manager/sendMessage/send_message_cubit.dart';

import 'ecport_injection.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // others hive
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  await Hive.openBox<PostModel>(AppStrings.postHiveBox);
  // cubit

  getIt.registerFactory(() => AuthCubit(
        loginUsecases: getIt.call(),
        registerUsecases: getIt.call(),
        logoutUsecases: getIt.call(),
        forgetPassUsecase: getIt.call(),
        loginWithGoogleUsecase: getIt.call(),
      ));
  getIt.registerFactory(() => SettingCubit(dataUsecase: getIt.call()));
  getIt.registerFactory(() => UpdateUserSettingCubit(userdata: getIt.call()));
  getIt.registerFactory(() => UlpoadeImageCubit(imageUsecase: getIt.call()));
  getIt.registerFactory(() => HomeCubit(postUsecase: getIt.call()));
  getIt.registerFactory(() => GetAllPostsCubit(allPostUseCase: getIt.call()));
  getIt.registerFactory(() => ChatCubit(getStreamUserUsecase: getIt.call()));
  getIt.registerFactory(() => CreatChatCubit(
        createOrGetchatUsecase: getIt.call(),
        messageUsecase: getIt.call(),
      ));

  getIt.registerFactory(() => SendMessageCubit(messageUsecase: getIt.call()));
  // repo
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(datasource: getIt.call()));

  getIt.registerLazySingleton<SettingRepo>(
      () => SettingRepoImpl(dataSource: getIt.call()));
  getIt.registerLazySingleton<PostRepo>(() => PostRepoImpl(
        postRemoteDataSoarce: getIt.call(),
        localDatasource: getIt.call(),
        networkInfo: getIt.call(),
      ));
  getIt.registerLazySingleton<ChatRepo>(
      () => ChatRepoImpl(chatRemoteDataSource: getIt.call()));
  // // usecase
  getIt.registerLazySingleton<LoginUsecases>(
      () => LoginUsecases(auth: getIt.call()));
  getIt.registerLazySingleton<RegisterUsecases>(
      () => RegisterUsecases(auth: getIt.call()));
  getIt.registerLazySingleton<LogoutUsecases>(
      () => LogoutUsecases(authRepo: getIt.call()));
  getIt.registerLazySingleton(() => ForgetPassUsecase(
        authRepo: getIt.call(),
      ));
  getIt.registerLazySingleton(() => LoginWithGoogleUsecase(
        authRepo: getIt.call(),
      ));
  getIt.registerLazySingleton(() => GetUserDataUsecase(repo: getIt.call()));
  getIt.registerLazySingleton(() => UpdateUserdataUsecase(repo: getIt.call()));
  getIt.registerLazySingleton(() => UlpoadeImageUsecase(repo: getIt.call()));
  getIt.registerLazySingleton(() => UploadPostUsecase(postRepo: getIt.call()));
  getIt.registerLazySingleton(() => GetAllPostUseCase(postRepo: getIt.call()));
  getIt.registerLazySingleton(
      () => GetStreamUserUsecase(chatRepo: getIt.call()));
  getIt.registerLazySingleton(
      () => CreateOrGetchatUsecase(chatRepo: getIt.call()));
  getIt.registerLazySingleton(
      () => GetStreamMessageUsecase(chatRepo: getIt.call()));
  getIt.registerLazySingleton(() => SendMessageUsecase(chatRepo: getIt.call()));

  // // datasource
  getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
            auth: getIt.call(),
            googleSignIn: getIt.call(),
            firebaseDatabase: getIt.call(),
          ));
  getIt.registerLazySingleton<SettingRemoteDataSource>(
      () => SettingRemoteDataSourceImpl(
            firestore: getIt.call(),
            storage: getIt.call(),
            auth: getIt.call(),
          ));
  getIt.registerLazySingleton<PostRemoteDataSoarce>(
      () => PostRemoteDataSoarceImpl(
            firestore: getIt.call(),
          ));
  getIt.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(
            firestore: getIt.call(),
          ));

  // localDatasource
  getIt.registerLazySingleton<PostLocalDatasource>(
      () => PostLocalDatasourceImpl());
  // others
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: getIt.call()));
}
