import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_app/core/extension/navgator.dart';
import 'package:social_app/features/home/presentation/cubit/get_all_posts/get_all_posts_cubit.dart';
import 'package:social_app/features/home/presentation/pages/ulpoad_post_page.dart';
import 'package:social_app/features/home/presentation/widgets/build_description_widget.dart';
import 'package:social_app/features/home/presentation/widgets/build_headerof_post.dart';
import 'package:social_app/features/home/presentation/widgets/build_image_widget.dart';
import 'package:social_app/features/home/presentation/widgets/build_social_button.dart';
import 'package:social_app/features/setting/domain/usecases/get_user_data_usecase.dart';
import 'package:social_app/injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: BlocBuilder<GetAllPostsCubit, GetAllPostsState>(
        builder: (context, state) {
          if (state is GetAllPostsFailure) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          if (state is GetAllPostsSuccess) {
            final data = state;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GetAllPostsCubit>().getAllPosts();
              },
              child: Skeletonizer(
                enabled: state is GetAllPostsLoading,
                child: CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: data.posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.white70.withOpacity(0.5)),
                          ),
                          child: Column(
                            children: [
                              BuildHeaderofPost(
                                name: data.posts[index].name,
                                imageProfile: data.posts[index].userImage,
                                dateTime: DateFormat('dd-MM-yyyy')
                                    .format(data.posts[index].postDate),
                              ),
                              BuildDescriptionWidget(
                                  description: data.posts[index].description),
                              BuildImageWidget(
                                  image: data.posts[index].imagePost!),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BuildSocialButton(
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 2),
                                      BuildSocialButton(
                                        iconData: FontAwesomeIcons.comment,
                                        text: 'Comment',
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 2),
                                      BuildSocialButton(
                                        iconData: FontAwesomeIcons.shareNodes,
                                        text: 'Share',
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Skeletonizer(
              enabled: true,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.white70.withOpacity(0.5)),
                        ),
                        child: Column(
                          children: [
                            const BuildHeaderofPost(
                              name: 'data.posts[index].name',
                              imageProfile:
                                  'https://firebasestorage.googleapis.com/v0/b/social-app-f2b49.appspot.com/o/posts_image%2F0263e493-f237-479d-90f9-7f9b961f8d90?alt=media&token=7d8ec4fa-d096-4a14-8c12-bc8d0669be15',
                              dateTime: 'data.posts[index].postDate',
                            ),
                            const BuildDescriptionWidget(
                                description: 'data.posts[index].description'),
                            const BuildImageWidget(
                                image:
                                    'https://firebasestorage.googleapis.com/v0/b/social-app-f2b49.appspot.com/o/posts_image%2F0263e493-f237-479d-90f9-7f9b961f8d90?alt=media&token=7d8ec4fa-d096-4a14-8c12-bc8d0669be15'),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BuildSocialButton(
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 2),
                                    BuildSocialButton(
                                      iconData: FontAwesomeIcons.comment,
                                      text: 'Comment',
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 2),
                                    BuildSocialButton(
                                      iconData: FontAwesomeIcons.shareNodes,
                                      text: 'Share',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user =
              await getIt.get<GetUserDataUsecase>().call().then((value) {
            return value.fold((l) {
              return null;
            }, (r) {
              return r;
            });
          });
          if (context.mounted) {
            context.push(widget: UlpoadPostPage(userModel: user!));
          }
        },
        child: const FaIcon(FontAwesomeIcons.circlePlus),
      ),
    );
  }
}
